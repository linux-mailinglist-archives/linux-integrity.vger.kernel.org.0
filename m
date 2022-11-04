Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C8A61A1F4
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Nov 2022 21:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiKDUM6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Nov 2022 16:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiKDUMw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Nov 2022 16:12:52 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE33F41991;
        Fri,  4 Nov 2022 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1667592769; i=@lenovo.com;
        bh=Bu3d8Cvv9vcjLZGif62lo+zXCChSX6OBtePieOWH17o=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=uRsDK8RiUQa6A9oqVqJ0gqXFmOVJ9Rdk8NKXfaBiYJzirPqYFfQ4C7e0zxrnMiVwb
         fA61ZoKJz/WRnyNLV5u1OK+yGZq6++yckPwCQxwvWgBfkQgxkyERFa99z6f5EvmgPO
         hW2Lt5FwrJRYCDQDAI7QR1N69T5RRzZhKj7BUjCyNGAK/7r1GqrlKyDGXQnmlcN9iG
         L1pufURtXfL3/sncqPuTZTfHXj5H9gH/E8HjF9RQBAfxX4Xpvhp73N8bSYSeRn5aHZ
         WnVGiPtBky2qGmb2Niug6UlWaIKDPKd7RPLBZWuQaJqnZhMDZ/V33BhFpiiieGbzWY
         LmDmTkhGGGy4A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpil+JIrShJLcpLzFFi42LJ0JfK0rUvSk0
  22HZe0eJd028Wi4krJzNbTPo5gdFi650mNosT546xW1zeNYfN4kPPIzaLW7NWsFgcejudzYHT
  o2vnWiaPzSu0PDat6mTzeL/vKpvH7CU3WDw+b5ILYItizcxLyq9IYM3oaHjBXNClUtG7VL2B8
  YFCFyMXB6PAUmaJo0dWMEI4i1glXrecZ+pi5ARy2pkkvuy0BkkICcxnkljxspkZwjnCJPGwfw
  MLiCMhcJxRovvQOiaITCejxI9Xp1ggnAlMEk9WTGaDcB4zSuxY+A6q7CGjxPaL69lA1vAK2Er
  MvvaEEcRmEVCRuLPpECNEXFDi5MwnLCC2qECkxKN/t5hBbGEgu/HnHFYQm1lAXOLWk/lg54oI
  FEgsPPQVbDWzwHYmiWVPVrJCbFvAKPFw1jZ2kCo2AW2JLVt+gW3mFLCRWPDmAwvEJE2J1u2/2
  SFseYnmrbPBtgkJKEv86j8PZksIKEi8nzqLBcJOkGiecpQRwpaUuHbzAjuELStx9OwcqBp7ic
  8v90PFfSW6tjyBmiMncar3HBOELS+xc+NtlgmMOrOQPD0LyXOzkJw3C8l5CxhZVjGaFqcWlaU
  W6ZroJRVlpmeU5CZm5uglVukm6pUW65anFpfoGukllhfrpRYX6xVX5ibnpOjlpZZsYgQmuJSi
  1NU7GJuX/dE7xCjJwaQkysv4NiVZiC8pP6UyI7E4I76oNCe1+BCjDAeHkgSvTF5qspBgUWp6a
  kVaZg4w2cKkJTh4lER4L9oApXmLCxJzizPTIVKnGL05rmzbu5eZ49qu/UDywYmTQPL8uksgkf
  UL9jFzTJ39bz+zEEtefl6qlDjv8nygEQIgIzJK8+AWwLLGJUZZKWFeRgYGBiGegtSi3MwSVPl
  XjOIcjErCvOdzgabwZOaVwN3xCuhEJqATt1UngZxYkoiQkmpgmmu2W9/le+nURjb+n3rbrm26
  FB79N7f2ZuuKlUv3e3759KNfMPcb87+yaTkhj7eVneqYs2MD58644keZB3SZp55Nj7i+wFHA4
  DWTY/cEeR+jlVb/NX+2x3N1f0lU+hvi2OT7dXN0R82bGoOHCw/OyzwZ8+WiJK9e1K65S62tLq
  gtZ0rys+YJWPI0OcB5iZK4u+TkRztCJ6b0rxViDmu6qmG6LiOtXFkjX7DnorGt931vTcsL8XK
  MhxQyq+7PP5rez3JNSP9eh7ZT7WJJfQWFmW/mTFEPm7V3weUKMempR23OTJi67ZvZpLlBwY3N
  N7UnZ3+dsX1Z6y3FSSeFMq4dvFTarfLvXXZvYUAQs36lEktxRqKhFnNRcSIAj6ohBpUEAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-15.tower-636.messagelabs.com!1667592766!210317!1
X-Originating-IP: [104.47.26.106]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13442 invoked from network); 4 Nov 2022 20:12:47 -0000
Received: from mail-sgaapc01lp2106.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.26.106)
  by server-15.tower-636.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Nov 2022 20:12:47 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2xvymtVijeVH/il8WHUNnjS+QiaMR6CHp99TWBe87loYt+CYhvXqnIKWJHjREAl4VqR6i9d86DeEVTdfXt0UxcxVao9pOkHTMdSlB9d6XF5IZO5Qyi09FUSujAPKxeRdiWU/Dq25jTOCnUPdUG/h1sCBygyt5eJ10J6CNSf9fjCQ/xN6C+tazGvF6SiFb0x+/CVdoRoZbOovK77bnqSW/gnequ9WfXxbbFtMuQBELz0rhjHwqsrjRNlrJYPq2iGMGXiuTJeXwrLt0i5YZz4Gg2R8XI6TScINBVZ7FtvXAmxidglqeT1GfEedotCG3IJZC3l97+0CAzOXoTAq2nugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bu3d8Cvv9vcjLZGif62lo+zXCChSX6OBtePieOWH17o=;
 b=bd8w5mOVMySE64kXuv1PUUgik/ciykfZF3vDOn7ZpjY71G4DpO5++R2rshpqBKwUFIQA5c/4d/cJCWzefCPlk/77t4Wx2eeR66V65tUFwHCfJxKmuxSba8pyeUhl+OVNQUvEh7ao3JFUW0qErDto7IO/6Dr/+o8F0iPTm1GmORL8W3Pzj/UXbls0oka/po8g0HUxkBqPGFsEv/g/OYv0CY+4FDj8ofPI58owAbpAVggW4UnvgBg9Zfem6VdNfUZi5R/Y35dWTWKwPPwXDPmKrCFeXGO56Ys4PEcqDFqRc7ir06htasZbspcuNUCmC4MWlaI4BQzgycDSm2Uc2eYOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=t-8ch.de smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from TYCPR01CA0155.jpnprd01.prod.outlook.com (2603:1096:400:2b1::17)
 by PSAPR03MB5190.apcprd03.prod.outlook.com (2603:1096:301:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Fri, 4 Nov
 2022 20:12:45 +0000
Received: from TYZAPC01FT027.eop-APC01.prod.protection.outlook.com
 (2603:1096:400:2b1:cafe::2f) by TYCPR01CA0155.outlook.office365.com
 (2603:1096:400:2b1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 20:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 TYZAPC01FT027.mail.protection.outlook.com (10.118.152.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 20:12:44 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Fri, 4 Nov
 2022 16:12:42 -0400
Received: from [10.38.104.89] (10.38.104.89) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Fri, 4 Nov
 2022 16:12:41 -0400
Message-ID: <12ceffb8-4e90-4eb5-2110-a0e69b412cea@lenovo.com>
Date:   Fri, 4 Nov 2022 16:12:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [External] Re: [BUG] blacklist: Problem blacklisting hash (-13)
 during boot
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
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
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <632d2180-02f8-4a5f-803a-57a6443a60f4@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.104.89]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT027:EE_|PSAPR03MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d90d6f-b66c-4457-f959-08dabea0ef4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhYKAA6jQ/FeIQUI4YNUzhSYuqfTKLUL0pxj31pr1r4x2KDfnFP5i/hjG7a8sA+k2bRX0TZmv6wpQzLvSFCT2XrR3LMrISE0fQRQ/D/jnRw8rbZUD6tlJ6iE1aYMdU8OEywA/2Rc7GrzC9IAzYDUTM4OEViZVrAtiyRXP4lvUxksCT0vUk1w7zHM4a+D6lviQX8U8Zi8r97wPCI+oMqH1z+UF/EZwDunSa51gxV7JM38Xs0MfUnLyDVEf0wDbSXc3heFTJWRCHHlkoDWolXOILhMT1MBvC98s0SHo2ngUJ+TSpXdkTMKZMkZePiaRSpftknuq7D+o1vboqPuDoMoL4el/UQie9LG6PfKjycpFQYyxc050ZgW03anBQZC8SIR9c0QFcCOvxAHMRYCiNdSA7JHb+/l6uSJZNcPYhVdIo0WA2bis3smq3uWHSBF0Yt8iKpcXOk6ZabQ9udvNQKsvOtZPNBfAKO6shzjTlpTq3Y2uQ2kMjL4r+1q+kCKTE6twMyzgMQXwOsh6zwLYaaj+tbcvqE5xPw1MBkbN/ALBDL0sSA5UZ6DvGskXQGNKmziibGHn6htCcnt2yLxdnCA7YApdFYgSmwdS/+NO9srTp4VvE4nvSDzghTQYe9pKX29ID12fjE8vU3oDs0MtPImA4H2kUff4LLEsFuAzH/0axEBSR/wUgjjzTDKSxaxpyTxJ/ZoI4DlEaQne3ZM74zOIEtwOZhPKzjN8cLK2ZtaOiMwEvF+pBCA7rBYxmu/ICC6gd0m2Nh14TYImGsnVjsLWFsMFZvDnb6y5qKXec1xsaJs6zaXVl5l1UJzQfM0+A/6UDtyHM47x4BrlUTCOj7NzfyG7utZaLVENhQFQyY6Cg0lyEOz3ACLi291MHnlc+i8k56RpjzaP2cF+jM/Oksh/WZO3YqLVc5LKFY8n0c8Cz6a6LrRSz2EIG70dDJVZwXs
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(70206006)(966005)(2906002)(36756003)(478600001)(70586007)(16799955002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(356005)(40480700001)(36906005)(316002)(16576012)(110136005)(54906003)(81166007)(83380400001)(36860700001)(82740400003)(82960400001)(86362001)(31696002)(47076005)(40460700003)(16526019)(426003)(26005)(186003)(2616005)(31686004)(53546011)(336012)(82310400005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 20:12:44.1507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d90d6f-b66c-4457-f959-08dabea0ef4d
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT027.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5190
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Yeah - sorry, I've dropped the ball on this one....was crazy busy and it
was lower down the priority list.

I have flagged this to the FW team (LO-2105) to get their feedback and
see if we can get it addressed on our platforms.

Mark

On 2022-11-04 15:11, Thomas Weißschuh wrote:
> Hi Mickaël,
> 
> On 2022-11-04 18:03+0100, Mickaël Salaün wrote:
>> Thanks for this report. These error messages seem correct but I don't see
>> any legitimate reason for the firmware to store duplicate blacklisted
>> hashes.
>>
>> According to the blacklist_init() function, the "blacklisting failed"
>> message could be improved to explain that only a set of hashes failed, and
>> why they failed. However, despite this message, this should work as expected
>> and should not generate any issue.
>>
>> Did you contact Lenovo to report this issue (i.e. duplicate hashes in their
>> firmware)?
> 
> I CCed Mark Person from Lenovo on this mail, nothing more for now.
> 
> There seem to more devices than just from Lenovo to be affected:
> * Samsung: https://askubuntu.com/questions/1436856/>> * Acer: https://ubuntuforums.org/showthread.php?t=2478840>> * MSI: https://forum.archlabslinux.com/t/blacklist-problem-blacklisting-hash-13-errors-on-boot/6674/7>> * Micro-Star: https://bbs.archlinux.org/viewtopic.php?id=278860>> 
> While there are reports that it helps to reset the blacklist in firmware this
> doesn't seem like a general solution for endusers.
> 
> FYI I also posted a patch that silences the spurious logs:
> https://lore.kernel.org/lkml/20221104014704.3469-1-linux@weissschuh.net/>> 
>> Could you please provide the list of duplicate hashes?
> 
> bin:80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d411f92659f0a
> bin:f52f83a3fa9cfbd6920f722824dbe4034534d25b8507246b3b957dac6e1bce7a
> bin:c5d9d8a186e2c82d09afaa2a6f7f2e73870d3e64f72c4e08ef67796a840f0fbd
> bin:1aec84b84b6c65a51220a9be7181965230210d62d6d33c48999c6b295a2b0a06
> bin:c3a99a460da464a057c3586d83cef5f4ae08b7103979ed8932742df0ed530c66
> bin:58fb941aef95a25943b3fb5f2510a0df3fe44c58c95e0ab80487297568ab9771
> bin:5391c3a2fb112102a6aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
> bin:d626157e1d6a718bc124ab8da27cbb65072ca03a7b6b257dbdcbbd60f65ef3d1
> bin:d063ec28f67eba53f1642dbf7dff33c6a32add869f6013fe162e2c32f1cbe56d
> bin:29c6eb52b43c3aa18b2cd8ed6ea8607cef3cfae1bafe1165755cf2e614844a44
> bin:90fbe70e69d633408d3e170c6832dbb2d209e0272527dfb63d49d29572a6f44c
> bin:106faceacfecfd4e303b74f480a08098e2d0802b936f8ec774ce21f31686689c
> bin:174e3a0b5b43c6a607bbd3404f05341e3dcf396267ce94f8b50e2e23a9da920c
> bin:2b99cf26422e92fe365fbf4bc30d27086c9ee14b7a6fff44fb2f6b9001699939
> bin:2e70916786a6f773511fa7181fab0f1d70b557c6322ea923b2a8d3b92b51af7d
> bin:3fce9b9fdf3ef09d5452b0f95ee481c2b7f06d743a737971558e70136ace3e73
> bin:47cc086127e2069a86e03a6bef2cd410f8c55a6d6bdb362168c31b2ce32a5adf
> bin:71f2906fd222497e54a34662ab2497fcc81020770ff51368e9e3d9bfcbfd6375
> bin:82db3bceb4f60843ce9d97c3d187cd9b5941cd3de8100e586f2bda5637575f67
> bin:8ad64859f195b5f58dafaa940b6a6167acd67a886e8f469364177221c55945b9
> bin:8d8ea289cfe70a1c07ab7365cb28ee51edd33cf2506de888fbadd60ebf80481c
> bin:aeebae3151271273ed95aa2e671139ed31a98567303a332298f83709a9d55aa1
> bin:c409bdac4775add8db92aa22b5b718fb8c94a1462c1fe9a416b95d8a3388c2fc
> bin:c617c1a8b1ee2a811c28b5a81b4c83d7c98b5b0c27281d610207ebe692c2967f
> bin:c90f336617b8e7f983975413c997f10b73eb267fd8a10cb9e3bdbfc667abdb8b
> bin:64575bd912789a2e14ad56f6341f52af6bf80cf94400785975e9f04e2d64d745
> bin:45c7c8ae750acfbb48fc37527d6412dd644daed8913ccd8a24c94d856967df8e
> bin:47ff1b63b140b6fc04ed79131331e651da5b2e2f170f5daef4153dc2fbc532b1
> bin:5391c3a2fb112102a6aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
> bin:80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d411f92659f0a
> bin:992d359aa7a5f789d268b94c11b9485a6b1ce64362b0edb4441ccc187c39647b
> bin:c452ab846073df5ace25cca64d6b7a09d906308a1a65eb5240e3c4ebcaa9cc0c
> bin:e051b788ecbaeda53046c70e6af6058f95222c046157b8c4c1b9c2cfc65f46e5
> 
> Thanks,
> Thomas
> 
>> On 15/10/2022 05:16, Thomas Weißschuh wrote:
>>> Hi,
>>>
>>> Since 5.19 during boot I see lots of the following entries in dmesg:
>>>
>>> blacklist: Problem blacklisting hash (-13)
>>>
>>> This happens because the firmware contains duplicate blacklist entries.
>>> As commit 6364d106e041 [0] modified the "blacklist" keyring to reject updates
>>> this now leads to the spurious error messages.
>>>
>>> The machine is a Thinkpad X1 Cargon Gen9 with BIOS revision 1.56 and firmware
>>> revision 1.33.
>>>
>>> [0] 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")

