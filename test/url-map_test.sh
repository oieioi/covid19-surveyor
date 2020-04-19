#!/bin/bash
set -e

. ./lib/helper.sh

. ./slack-bot/url-map.sh

echo test get_channels_id
## setup
rm -f "tmp/channels_list.json"
actual=`get_channels_id`
if [ -n "${#actual}" ]; then
	test_passed
else
	test_failed "not null" "$actual"
fi

echo test get_members_list
## setup
rm -f "tmp/members_list.json"
channels_id=`get_channels_id`
actual=`get_members_list $channels_id`
if [ "$actual" != "" ]; then
	test_passed
else
	test_failed "not null" "$actual"
fi



echo test get_title_by_res
res=`wget -q -O - https://kantei.go.jp`
actual=`get_title_by_res "$res"`
expect="首相官邸ホームページ"
if [ "$actual" = "$expect" ]; then
	test_passed
else
	test_failed "$expect" "$actual"
fi

echo test get_title_by_res
res=`wget -q -O - https://www.city.funabashi.lg.jp/jigyou/shoukou/002/corona-jigyosha.html`
title=`get_title_by_res "$res"`
title_expect_result="新型コロナウィルス感染症に関する中小企業者（農林漁業者を含む）・労働者への支援｜船橋市公式ホームページ"
if [ "$actual" = "$expect" ]; then
	test_passed
else
	test_failed "$expect" "$actual"
fi

echo test get_title_by_res
res=`wget -q -O - https://www.pref.oita.jp/soshiki/14040/sodanmadoguti1.html`
actual=`get_title_by_res "$res"`
expect="新型コロナウイルスの流行に伴う経営・金融相談窓口の開設について - 大分県ホームページ"
if [ "$actual" = "$expect" ]; then
	test_passed
else
	test_failed "$expect" "$actual"
fi