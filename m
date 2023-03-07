Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1431C6AE107
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Mar 2023 14:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjCGNql (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Mar 2023 08:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjCGNqR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Mar 2023 08:46:17 -0500
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com [67.219.246.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A5F838A4;
        Tue,  7 Mar 2023 05:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1678196745; i=@lenovo.com;
        bh=5TKtPd3FIrRGX5rbWKXZw7weseOfLoQkBcYoBvOS0p4=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=jTT7v17TVQv+LxJ4aPSUjlYnCUq/qa1Q6NJybE81gCFhAQxSMRljA7beCTfr13P7o
         jVmjLYamryl87xeCYLGV3f5C9oizjuONAqBc1kTPlTCGY1zP0yw5NV04yL8zIUchl3
         SYDZAk/LKcCdlWtVMfNTIdThSvE+6atjTiJc4ib7hU3bWrxl4ztXM9G9/+viHrYsnP
         TO/YhuQ5O+U3QKqkjpCl5GAFxYkfCWIkZR6x+xjAlrnuqJnfLv/rdW6nEfgth11lzj
         EhRwCjCL0z2uLxEmhdTm0TdcVughPinG/ZVMivm1+YFhAV9YYJ5HIsMLlomZbNeV9d
         f8tdUpS52laLA==
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0wTZxjH+95dr0fllqOV8VIRWEFdcO0kLu7
  CAjiTxbpoJMaYoNnksGfbpBTWK4gsy1r8Y4Db5NcklE6GsvJDplAZvxywIbDCRBq0TituwfHD
  EXCom4LOZdceOvbf5/t+n/d9vk/yvAQqW8AVBJtrYc0mxqjEpZj+dYVKRWyVaDctzr9K38t/i
  tElDWUoXbpUDOifT1kl9Lfj+TjtvjIooa92OXB64dM7OO2z12N033wFvlWqudbThGiKOr9BNB
  fq4zSuxkJc80ePF9dU1d7ANA9dkSmS/WKDKT0zN02s97WcRrOWyNzK83cRK6hbVQSkBKC+RmG
  JZxYVxGkxrG3qFguiDIFTt20Sv5BRXyLw9/xSRBD9CPxipBz4BaR+BPB437llpxDAxdlhTBAl
  CPxusJYvC+LFbwAWNMkFYwLAmuKpgEFSibB+ekzsZ4yKhVcn6pbPQ+BQ5STm51AqFX7S1YH4W
  c6zbckRqEepMOibrA60Xk1VAGj/0xXIjlLtCHRONoiFduUo9I55A1dwaiNsbX2CFwGCCKL2wM
  tznPASDc/M/SAROAq2zztQIXYMfHJiNMCQioZnZ0aBwGnwWPnAMofD6zc9EoHXwoERByZwMnQ
  32MUC74K2xw8QgSPh8GdXljkKdrbcworBa/YVQ9tXDGdfEc++It5XAGsEWzjWnMOaVfGb1Olm
  g05vyWAMRjWTp2LU2ZyKZTiLKl7NHOHULMepuaMZh4xatYm1uAC/fFoz3tEBbnz+TN0HwglEG
  Uo+XCPRyl5Kz9Qe1TOc/qA528hyfSCCIJSQ7HiL90LMrI7NPWww8iv83IZEsHI1WbqFt0kui8
  ngDDrBGgYq4lpbdzcqw0yZJlYRRqYm8UWUv0ifbXrxxPOPMAbWKuQkEIlEsuAs1pxhsPzfnwV
  hBFDKSY8/SbDBZHnRaZYPgfAhPL2YP4SF+c9SWBH3QIje5r1X4y0Y2nz7mHOfYd2e8bzEW872
  66H9zdNBF0Ic0/mp730Q4og0hUvbBi/vrp4k9w8N6tJHLnYdlk/8tDN1LqrgYu2G5v6P3yY8v
  Tk5j6I+WlU5cWlRsv6dxEKXOxxasQN5697cvvmkt+qgJyZIfqgiKfqNmZng8GcKkXmb8fsdWM
  9f8cEfvtK6V647EbPB1VvnznVvrKblcdr8x859I72u2F9j2+KolJuPyjyj23danZ2LyS9HJCT
  8UpVceRf9W+edcytaG+cSoi9Z70+sx8elR878s2abrWaHKOn9+827W/bGnwSJD/JOpRy/87R6
  gSPfjbAf2IX7fN6as2lTSozTM/FxqJlj/gXvxYmsgwQAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-12.tower-706.messagelabs.com!1678196742!237258!1
X-Originating-IP: [104.47.26.45]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.103.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10077 invoked from network); 7 Mar 2023 13:45:44 -0000
Received: from mail-psaapc01lp2045.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) (104.47.26.45)
  by server-12.tower-706.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Mar 2023 13:45:44 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2sxlvWnpJ6lCBotGUFFfqM4Mod3vIb8FI9X6sUK+1Ykt+MK930SakSuBBKRuCCBgGb3TmM5es3SPR8lRTU3Z8m4TdekG+a8yB2O7XwhWolxVgd5CLP8tE5UBpiAdqigQQ4k2vlNOOXJeR6KqZ1Ukjps6WniAOIQgr1K/1EekQlWnzMDYCrHdq3Q//JV+7O+FU+qW6g++3Z6CRa0jc5IH9AEcjtUcapF64lIHVWdx5GnXpeQVeYCVxsQkUgGFQve9Gp0QyCHJ1SPVjr+2CcLAOWDWpWKeYNOKBA6lJrix1EQpRT8MLqdkgTl/+cw9mrQhcLLgLe3M/NR4kC9+l/TCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TKtPd3FIrRGX5rbWKXZw7weseOfLoQkBcYoBvOS0p4=;
 b=MdF6HnX3UEl+oVm1MNfHQoqMAaVE8fmjaePeud8MYVLpPXdTsiqfGWxSQmAp3yd6PmZjraS4dESewwtl3MQsV4tRbDppLBlIl8VrpgruGvolaZuzYqGq10fNB220QS3gB66dAe5i4Kf699N6TGU2ordZGiz0/7e3DrvpoAG5Wsvm3QDog17+hEhKUa5A/P0Jy28Z1n6q88hUBDyeFgFQX5oIgGDZ+8Xjs8+U2+QL3LWJz6+uh6Z9Rj9E5S/U0jQEXQNZl/PQxqLBU/8PbthhApSTmgneWxcuIwv/O2LruLEZ21DoqgITlqEeKaSdjajF4hR4Y9cqwMtKjSy6CCfNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=lenovo.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=lenovo.com; dkim=none (message not signed); arc=none
Received: from TYCP286CA0095.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2b4::18)
 by SI2PR03MB5195.apcprd03.prod.outlook.com (2603:1096:4:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 13:45:41 +0000
Received: from TYZAPC01FT020.eop-APC01.prod.protection.outlook.com
 (2603:1096:400:2b4:cafe::95) by TYCP286CA0095.outlook.office365.com
 (2603:1096:400:2b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16 via Frontend
 Transport; Tue, 7 Mar 2023 13:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 TYZAPC01FT020.mail.protection.outlook.com (10.118.152.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 13:45:40 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.21; Tue, 7 Mar
 2023 08:45:39 -0500
Received: from [10.46.192.34] (10.46.192.34) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.21; Tue, 7 Mar
 2023 08:45:39 -0500
Message-ID: <1bb01e6c-3829-6af4-b2c5-5dc82bd75b72@lenovo.com>
Date:   Tue, 7 Mar 2023 08:45:38 -0500
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
 <2a215e4d-bf55-b063-3f1f-a63f51cbdbfb@lenovo.com>
 <c5d674bd67735de460b19fd955f718bf8b604c1d.camel@codeconstruct.com.au>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <c5d674bd67735de460b19fd955f718bf8b604c1d.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.192.34]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT020:EE_|SI2PR03MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c99766e-e35e-428f-ac4d-08db1f123dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzvNWdfLybihXyZVjLSqE+UdVySQFhzF7A2wTSxVxYfHKSue0BP1sEC5XAr5l34fH7RzDU+Lw88Stlht6pEb8GhFyikeuvo5iOvFTJcVlEbMi19DyY/FL5SDuSn3LI72/99psqyqi6dAokTEdT+Z1A3mDpTNP0R6rKLfEhXzvguA4KWafXGYnOpfHgVPMlJL0vxUsVRb2pxUWmweG0IYp9rG7sLfcgTnTTIZ4Dy7cPdiED1QIPRCNlM+a9KbbNOj2m2ST2zbf1vsaHIx+stM8ZvyI2XugQQuOWL+Dqemx1IdpOS5s2yEKZXKbuY1izb7vAjn9doe0nPir1jT6yrVqDzfnmAZ2SxuNKrw9+CdPO9+4quvNxtI40VVQDEYTUZRkPGe49IgjlZ7UruPSNEjNPuRlgGh1q5EJqJcGMCZ7UyTGt4ESK0481wLY2/2FOJ52lnGC7EYs7ih2G9Qx+/yYPH0uwpVlabdtOCCWWv4eAJVxjcwLXz/Hvc2sCF30c7fwKku/ZiLneS+ro9KwbscDS2XNX3H8GneMc1s7ghwx80JOXZuuQMTGV/c+hgSMcD52+21zbJ9B330zJIDoqTX9OVqPgJP9SfKU5PU1g0eBwfFx7u7ouCmF5JbJDVUxU5LyXHNQwA0ybi0duyeaqJ40Y+boqOK7tz1Yet/EJPIIEtknvZqg2zYe46+i2FdFsZ64nKh5cV7cquvFR4ZoFWmL1dbfubotwMFSwMuvKMfj3JpSCED1MyBfhqBTy3iPYd5tcrMUnBfBu6GScV/fs9IjwgZc+1FscSAXiZCyTnkWXOpdZe4+8l3iNUTjXb7ZT2rX/Vn+ZYEmfQrnTZHJn6S8g==
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(31686004)(8676002)(36756003)(4326008)(70586007)(70206006)(40480700001)(41300700001)(8936002)(5660300002)(7416002)(2906002)(356005)(82740400003)(81166007)(31696002)(86362001)(82960400001)(36860700001)(26005)(966005)(54906003)(316002)(110136005)(478600001)(16576012)(82310400005)(47076005)(83380400001)(426003)(2616005)(186003)(40460700003)(16526019)(53546011)(336012)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:45:40.8993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c99766e-e35e-428f-ac4d-08db1f123dfc
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT020.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

On 2/27/23 09:36, Jeremy Kerr wrote:
> Hi Mark,
>
>
>> I've been looking at this and the FW team are claiming that it's not
>> caused by duplicate entries in the dbx table, which is honestly a bit
>> confusing.
>>
>> We've been doing some more digging - but is there a possibility this
>> is caused by something else?
> I can't quite trace where the EACCES is coming from, I can't see any
> obvious causes there - the blacklist key type doesn't have an ->update
> operation, and the assoc_array insert doesn't look like it would fail.
>
> However: if I delete one of the duplicate keys using the bios UI, then
> the number of errors logged decreases by one.
>
Got to the bottom of this, after a longer exercise than it should have 
been. I have some answers.

The entries are indeed duplicated in our DBX. The reason for this is the 
FW team took three different DBX list published by UEFI forum in 
different time series and combined them. They did this as they found 
some distinct hashes in previously published ones and chose to combine 
them for safety/completeness sake.

I haven't myself dug into the revocation lists hosted on 
https://uefi.org/revocationlistfile but it sounds like there was some 
churn there? The FW team agreed that duplicates should not have been 
created.

The FW team have pushed back on doing another update for this generation 
of platforms. Updating the DBX to make these changes, particularly 
removing entries, will apparently be difficult. I prodded a bit into the 
details but given the issue is essentially cosmetic I do understand 
their concerns (the last DBX update caused enough issues...I'm not sure 
I want to go through it again in a hurry).

They have said they will fix the tables for future platforms.

Hope that helps

Mark


