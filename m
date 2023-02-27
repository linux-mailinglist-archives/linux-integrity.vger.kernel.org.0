Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566386A433F
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 14:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjB0NuH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 08:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjB0NuG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 08:50:06 -0500
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com [67.219.246.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BCAEC57;
        Mon, 27 Feb 2023 05:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1677505092; i=@lenovo.com;
        bh=trwLOMRGoK6X1mYWhmqAcbd0EhKdgZLfX9O5b20Z29o=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=MXSlUfj7GL6Ub54qkGhG+bLrTNoTN4jnAZwxPo2bwHRydJOlvTUE9t1yisMC2dZOr
         oNseL6zDKY5hYTzkkg+QYSpqeHBWf7OBYq+kqNzMmd4e8N7Stnj0m/DaHtXujm6n81
         5Blwn5eRHyvkz0bFUj52luLgM4rUvoOKcinpRCFQFO+KR+JzxPd0f5dJB/4SMUtf47
         EV3Adx0UvtmY/i37J7CULEtH/unSqSSMOFrPvkzHSlMoRlLth4W7fKcHY3PTKwuwPj
         r5YrPzhevV3O/HYuFBHpK8UDN4UH+mR4oVlUzKQ6bKeIomg3m6IOrbtMUgUWkut0lZ
         bVk+IMKZhOF2A==
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0wbZRjHee+u16Oj5GhhfYfCtNsSM+y5Jiq
  niTA3lzUaoxnJNqaLO+BGm9EW74p002hX4o+VOX60kVE7dRMQ0I20dHRFGZYwBo3CRIYbOAnI
  foTIgAkKDIzX3jbxv8/3+T7v83zf5H0JVDGFJxOs1cJyJqZAjcsw/RMmjWarbyl3U8gmpW/b7
  2J0RYMTpSsXygH9y2dC7eyvdpzu7u2S0j+3enB6+ugYTg+56zG6Y7IK3yzTDZz/BtE5gqcRXX
  P9Rp2v8Qiumzp/Gdd9WnMF0/3pS31VukdiMOWYrfsk+j7X6sJyibXGOyOxAQfmADICkLUodHb
  MSUVxSgJ7pmckonAi8Pq1w1FHQZ5A4N9ePxDF9wicbhyNOpC8CGBpxxlEdI4AOD8RxkRRicBl
  1zAqinEAr5y+dW/AGIA3Wz8RHIKQk8/BpuM7HSCWwMgN8K/fZpEIy8kE2FM9jkU4icyGH7aei
  9aVAh9e8EgijJIqODT+eXR1IlkFoHvWF82OkgEE1o03SMRtbgR6Z9ujR3AyDfr9i3iEY8kdcO
  C7RVQcRcMv/whJRV4LA5OeaF1BroOLZX3RpJB8BJ6x742UIbkPlrguAJHXwMGrl6Qip8ALP3o
  wkTNh1YIdFfll2O623etJheGPexGR18KgdxgrB4+7V1zaveJy7hXp3CvSfQGwRvA0z3JvsZxG
  +ySVwxny9RYjYyigmEMahiriNSzDWzRaiinmKZbnKf6gMbcgjzKxFh8Q3l4eh71/DkwdW6Y6w
  BoCUSfJT21ZylXE55jzDuoZXv8GV1TA8h3gYYJQQ3lik+AlcGw+a91vKBBe8H0bEnHqRPm7jY
  It5wsZI2/IF60w0BADLW1tqAIzmU1sskqe4BWayEiTvsj0YMT9f9APUpKVchATE6OIK2Q5o8H
  yf38CqAigVspt9cKUOIPJ8mDThBACEUIERucjISzMf1ayDfEgrfaimea533Ht9tdSB5UhXVvp
  3uKgzLXppOorz/alzaU/xe7y164fCdLN6UH3P7DioZoK5e2UwWtEl0VbVq03O8uWVWVjRGfnR
  1mve+q3Da/b2RM4sapSn9F/50b47KVA4ovdWxQZP3Ru2OatS2tJCKSvfqp5V3x6KC6z/YUS7f
  zulle6R/zPyhD/AWfdsaznYwcW8UfvZHOuPmvD8pu1zgZ/JUWcrOMyw8VlfPlE9o2ZQzdLqNp
  x9WMpTsNd49t8dX/XS4W1pmcWskLHj+7PeufrySRw3Zx1+Vvb0A4qf2sj05R28b31mg9kupo9
  u9H4A6tGRnqbMlJHHcpbVxPm1BivZ7QbUY5n/gUXybrUggQAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-11.tower-706.messagelabs.com!1677505089!316570!1
X-Originating-IP: [104.47.110.45]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.103.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22627 invoked from network); 27 Feb 2023 13:38:10 -0000
Received: from mail-tyzapc01lp2045.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) (104.47.110.45)
  by server-11.tower-706.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Feb 2023 13:38:10 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1D5wXH4TSbH4HtZacDonN/4i1YFSiCwb2M0rwSU+A7PfCv0WSi2ZIVXhzDzt0mx8SNkVgCzFIcxdtnYEADx6Fi2rJo7y+7U5jki17gWo70636wjt6p9b3APVliQzkDLa9O6qA09Ozyj+Ie31NagPs1Jc3arPyA+wTZsJyQMseBNOnHzNwzmWDx7Oc+GSAbgHI8ywnAN1oCMtx6LqOrnMATtdUqvvt9sxAqd0lkJr9oNb78UVqwJeS06F7FkGbsUvuUMoaw6zhBXmP+g5mdNP072Dgp0lFm+6pMaBGUxI34t+jChEIGvcfb7VoY5yBATQShICOS4XA5k6vy0BEe2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trwLOMRGoK6X1mYWhmqAcbd0EhKdgZLfX9O5b20Z29o=;
 b=Xn2Igr+/UaS+ssxdzC2NILReOise8v2pMflsrgGtI1kTBkc7tP2yK/bXsruaZOZO7Brkxw6N50DzGMONmIWMCxY2/5Ej65+GsWE0pNfzVmw2E+pfs0y2TTyywHlqb8irS82WNQqwtbdIE837YnCnB35Qss8Qv9oYqfBjtzt/t4tRND3XgxjhJnag12mC5SnNzW97+zXZPngi8s98H8LA1paH4mqPfvgKZhb0RYeNuQTTRBFubmVMOkKnpJR6adw9xJSns41I6OGLGW9U+B3LkkejIQUDTY6n3HlSgtIZh6D4sI0aef0wvxbzSXeAM5+RK42YyPqFUUTGngqLhGn5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=lenovo.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=lenovo.com; dkim=none (message not signed); arc=none
Received: from TYCPR01CA0101.jpnprd01.prod.outlook.com (2603:1096:405:4::17)
 by KL1PR03MB5713.apcprd03.prod.outlook.com (2603:1096:820:73::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 13:38:08 +0000
Received: from TYZAPC01FT033.eop-APC01.prod.protection.outlook.com
 (2603:1096:405:4:cafe::8) by TYCPR01CA0101.outlook.office365.com
 (2603:1096:405:4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 13:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 TYZAPC01FT033.mail.protection.outlook.com (10.118.152.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 13:38:07 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.21; Mon, 27 Feb
 2023 08:38:06 -0500
Received: from [10.46.218.88] (10.46.218.88) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.21; Mon, 27 Feb
 2023 08:38:05 -0500
Message-ID: <2a215e4d-bf55-b063-3f1f-a63f51cbdbfb@lenovo.com>
Date:   Mon, 27 Feb 2023 08:38:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [External] Re: [BUG] blacklist: Problem blacklisting hash (-13)
 during boot
Content-Language: en-US
To:     Jeremy Kerr <jk@codeconstruct.com.au>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de>
 <af0d6881-76c0-f570-0c5b-f664e261c4cf@digikod.net>
 <632d2180-02f8-4a5f-803a-57a6443a60f4@t-8ch.de>
 <12ceffb8-4e90-4eb5-2110-a0e69b412cea@lenovo.com>
 <fec5e8eb3803068a11267f386ddda389a1211736.camel@codeconstruct.com.au>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <fec5e8eb3803068a11267f386ddda389a1211736.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.218.88]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT033:EE_|KL1PR03MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: bab264b4-1443-4532-3fb7-08db18c7dc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBQpj569Wrji1t2sRaiW0ld2PuD+d7xflkwX6hz2FxVf9J0uhujNc/QSI7Y8z0uqxGZPu2ryKBm4ErYreWmM4JWhU0lNzM+U7E+PNXQ2M0NGkoZE0ET8qB9pCqnCoTnFw8XaoPfXbHVJDjobqm2Cep20Ti4kPvt1p897MoWxzOKGKRDla/zOK/+R/T6hQz7L1ufplivE0qFp+xVZvkEVTVEl/tU3g9NWpYBu+vFI1URBETos9dgxaygwuqL5z89AuFrsNse6V/JOFtBluWVX3EFyWeHyqq1CIveWcoGq8vF4ZVl8G9D+izCmTWaymvzvlx+d/xJXupAeLUaYOo35Z1UC0Pamw4weJjtFUQvTqPY6Bof0j1U0ZDPgCq6+GQxiHZpR/jviy29ZN04InLtxbLAY6j1H6BW1lXYEhaJuEnEHMZKEHTC+fWb5ve4mQ49S5aFm3TRFkWcVq3cL4cVXhnS1vecaiGhAuwAXPWZuiHGF0YYNZslfi876JUqpepfOS06TS5Y9fzD4O0aejrHZ39rSVV6Rqsb3qRDzZOrQQsQfoJZO4Dvn1s8aoQvpQyjx3pFKgWaI3uvMQYb4322zTJpGuCPC26WUq2HHNi1Rne6iR6tyjk8KI2YNMPw5HQ5a/i3uQ1fwDGTtUmll8gJvi8DUvi05TQjuA2KF/kHfRPyWxtF+Qvax/6gWn2Vd+P/UZ9aJuxudVT4v/cydovo/K/IhShKgtfUcc0mSh0e9doGzB1ecCjYg4SX2mNrJzdWnM/jVQ+CavUvUHVUn+0bea2Uczp8q9H9MIr3O2wAx5vo=
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(31686004)(26005)(186003)(70586007)(70206006)(8936002)(7416002)(40480700001)(5660300002)(478600001)(53546011)(16526019)(54906003)(16576012)(110136005)(316002)(336012)(47076005)(2616005)(426003)(4744005)(82740400003)(356005)(82960400001)(40460700003)(8676002)(4326008)(41300700001)(31696002)(2906002)(36756003)(81166007)(82310400005)(86362001)(36860700001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:38:07.0729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab264b4-1443-4532-3fb7-08db18c7dc2e
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT033.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5713
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi

On 2/25/23 22:42, Jeremy Kerr wrote:
> Hi Mark,
>
>> I have flagged this to the FW team (LO-2105) to get their feedback
>> and see if we can get it addressed on our platforms.
> Any progress from the FW team about this? I have a fresh-out-of-the-box
> T14s with this issue, there's 33 duplicated hashes in dbx:

I've been looking at this and the FW team are claiming that it's not 
caused by duplicate entries in the dbx table, which is honestly a bit 
confusing.

We've been doing some more digging - but is there a possibility this is 
caused by something else? I was poking around at the kernel code but 
haven't got to the bottom of it yet.

Mark

