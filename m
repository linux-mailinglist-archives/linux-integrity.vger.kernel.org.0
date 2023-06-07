Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F18726395
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jun 2023 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbjFGPB4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jun 2023 11:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240973AbjFGPBt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jun 2023 11:01:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF601FC8;
        Wed,  7 Jun 2023 08:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6DrzxAKQ0qozRz1T4TKnbrpVjJ/yCJDFuP4hLqoPI5W0cZAs1gWDkPn1nMLi17pfN1e4zVlbhJ+frOW5QL9fwgUre2MRRAUTshNia3ZuCYrMm/F3alpZqzV173jto4E2J7PpvS+CcJB9ZGm31V1Vjwnn1+BdWR9NOWxlreaS8/Hrx2yFRz4gpk/3ukjDaMY10klUnuJO7WrLehCYbT3SYHfzCdMrTDjfyoXu7wKUYvNh7C2MJaOcY7Kfpt6id+OiorIFpXALhhyC/CJ7in2F8ikd+e5ibURL/qxxcpArofwOZl6yjxYEvVQDOSDF6o3F/SaaBqyoH71keZDE0T0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4xYOstrbq3AKOI6+1Dnxm06dgtvExOXAsD2Goeg+Uo=;
 b=ZoFSpvsOGN5/KYXb5YT/+Z/xwf2z4yXUwWEf5aYdeHT7I8RtOCKGhnfmCnwdRK4MgvcgYnLqbSjkOvf2+CAG8sI3hlOM8mO4dYKgEnDMQG8HR6vKk5lU4un+b8OkcZ83POst5L1D7L6QdyKzBibvUbeLEUorbF7yr1XssLU0DelgbWNclrXb36QOan4gT8fAk99wM52S+0LHoJilBneS8R3wd+jddrLjQHchK4OfiZgn+db8LRq5eSiGZoGmP/pZn5IygfH002AehWUCIUmg27ha/AH5tlZhb5qvmR+2Ff3Gx9klLpl+Z3J2eL1f+byyBGsIqVmlJGECeui73xuBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4xYOstrbq3AKOI6+1Dnxm06dgtvExOXAsD2Goeg+Uo=;
 b=EACtFb7Z52xhnx10s00fcHLiw5I9MDvcFBSg2n+HA+TYIIfVD5KkfsI7uN6S4QfarDYbOg9M47TYDAICSfClKkhx9q+H8/0dgc/84A07DDOHdOFLFekH+dOpFHv4QeaB/ayfaWMdUFyCVNJdeRv6EzZlctkl+lAYLe3jJ3pnELw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PAXP193MB2379.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:226::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.18; Wed, 7 Jun
 2023 15:01:39 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%7]) with mapi id 15.20.6477.016; Wed, 7 Jun 2023
 15:01:39 +0000
Message-ID: <1f8fae1e-5610-1ce1-6db6-a57f4152c9d7@kunbus.com>
Date:   Wed, 7 Jun 2023 17:01:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linux Kernel Integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Lukas Wunner <lukas@wunner.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <ZHQIFLWvrWUNMVxb@debian.me>
 <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
 <2b09d2ed-0852-bbc9-b792-aad92235c7fa@gmail.com>
 <03daca5c-e468-8889-4dc2-e625a664d571@alliedtelesis.co.nz>
 <ec5245bd-3103-f0c7-d3ef-85aabb4d4712@alliedtelesis.co.nz>
 <ZH6TIjXeXJVMvSKa@debian.me>
 <f905141c-1f8e-aec8-470c-19d476e567a3@kunbus.com>
 <68e7cee4-4136-3940-2007-55aa094ff790@alliedtelesis.co.nz>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <68e7cee4-4136-3940-2007-55aa094ff790@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PAXP193MB2379:EE_
X-MS-Office365-Filtering-Correlation-Id: dde23ef1-a0ae-466a-5319-08db676818ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WgWMeYMyEtoGwKe/QIR5XKUax0lNJHNb7LrPtF2WKZwIy6xzWRJbIIhyXlCCy3mCsnxaoz42EHATViGIyil5qQsyrtglrxUVhsKfrr3/fHmlg/Ke91OiliPv4hmGrvO4sHgodiSiFgtFMof4ebZ/FaWNNXsuaaRKRnbhRBpQ8KEX84YY73bm4HUd/2A7xqaw/AOQPO23uYPmA/vqfAAzBwKtV2rcuA/hQcNtzepXLUinyvjbwGh2nc91dP5caPMw/Xq+WOgNjnbeV9fo6nCQRuJisqqxCUc2qSBHz2YwZ9yvqh043H6LANuye4GT3mhaSKVTBDUQ1PmLgzBQYzh/CYEuMzSaDfzJCDoJkpIzwdWXmSxQDd92N44ZeJMcVT6/dy52gQ7lRxwAjHMvilb3OiNAbyZjuCW4fQG91khfHhASMHI/V7tblfIcZnZPyhW8gFWwOAyntv2zQZYY9upV7xTijROK4B5QFpEvC7iwnwxxg+Wy82jSfKKI5Pw0+72/t3nuL+fs6xUy5OT7qSFWZsKjA1kVk9fMa5z9vjJQysyJgcgcM9xrb161ftvCHTsyBgDXNtSV4Z2ZU9Wm/LiggMBZHOfS//q39KpE1QP/l0uEW4BD5Q/dnGW0MWNkpPpEI+c63WLcNpS+IMnc7wiPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(39840400004)(136003)(451199021)(66476007)(66946007)(2906002)(478600001)(4326008)(4744005)(8936002)(8676002)(31686004)(110136005)(41300700001)(316002)(54906003)(66556008)(7416002)(5660300002)(52116002)(6486002)(107886003)(6512007)(53546011)(6506007)(38100700002)(186003)(2616005)(83380400001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE5pb3VSYzNrN1ZZK3M0cExPWWJEeXE3RzlsZWNIRlRFckZwOWppVDB3Vktp?=
 =?utf-8?B?dnFnYUkydTZ1dTE3bTVNeVdYV1BLakxmQjlKSFY5UVpaL0E4ZEdBL3dsREcy?=
 =?utf-8?B?NnVlTEZHd2toTFZXblozTjh0VnNWNzRFK2J4YTRzbElOMG8zK3FvcXhWZ2NT?=
 =?utf-8?B?T21UVkQzOU9HeTBaSFJDUmlFQ1l4a3ZKbUFtVWx2R0hZdTlNRVVnVDVlWS93?=
 =?utf-8?B?ZzZkOUxlZ0M3VlVwTnhuY28yM0pockJUL3NvdzJDTU50ZTFtaXJjN245Q0tH?=
 =?utf-8?B?a2FoRE42SEJKbG9wdy8zQzIxamJ4aFNjelN0SG52N2tITkVMZEYwcEFoak9N?=
 =?utf-8?B?N29IYW5iQTI5UzYrWG9aQVRvUGVTbm9ESm5KSlg3aCtKSTNrSzFIb1hrTy9C?=
 =?utf-8?B?WHlmZC9IcDRXWEh6VzlpYTlkRUhYU0VlQ1pqVkV0UUg3anM4WFA0azNjN0hG?=
 =?utf-8?B?RVdzaHFudzRma2s4dkJLOFpyT3Bpa1ZVbEpkSCsxRjgvTm1weGZIUmpXaDl5?=
 =?utf-8?B?d2JVQmRVbXBIU3IwbU9STkZ4K0lKdmgrSEppOXBnZFgrSFZKSVVFWUFLUWNj?=
 =?utf-8?B?WmsvSWVkdmFSUjBVQ0NQb3gxLzByL3cvMzN3N0JoMHNFcjluRTNyZVV6Z205?=
 =?utf-8?B?Zk44elN0dGhzTVVqRG1zSElnUXI0NERzK2VNYTFnMTRFaW9MRFlTOVh5cmpS?=
 =?utf-8?B?c2x0b0RmV1pKQnUvaVVCRDRieUdMU1BKcnkrWWxnalp5b1llaXlnNUJIRGFM?=
 =?utf-8?B?KytudHFtM3k4NUlNUFJINy9HRklPbmtta0lNVVhxTW9aZkdHbThZcGI4ZDAx?=
 =?utf-8?B?YzdmZzFIV2s0S2dYZ0xuYVhBbzNTTmt6YjhZdTVMam5jSXd3WTlGY1pBS0JH?=
 =?utf-8?B?WFdnN1M3QVVmM2wwbUQ0UWwydFBTdnJOQkR0ZHVYREJOUzFMeGZhQ29nV04v?=
 =?utf-8?B?RWdTTGdVaHNHL3JmTkZwcW9KOEZFWFU1NlVJTlRrWjByQ2RNNUpFcytDMVVy?=
 =?utf-8?B?c2t1QkVHVnpFa3greVdKMkhjRjFwL1dFQU8xVU5ENUoxeTZ3MUtuYWRoZ1Er?=
 =?utf-8?B?R25vOU9hbWRoWXFWekUyZjNxUkVwZ2RPdW8wUm5zd0ZPRGFDK3l5WXdPRExv?=
 =?utf-8?B?YlMrUlR6M1cwNEJ5REVKbDV0Y1lJblByR3E3SVVycHErQ29QOWRHV0tnYWtG?=
 =?utf-8?B?T0o4OGNkVUZTQXM4ZHlVaTFRUjZISWlsODVpaTJSWU45bEEwc2dER0lFemxh?=
 =?utf-8?B?ZDJLditiOC9pZTNpVzZZZmhLTG9xYlV0V3kwbEdzdmVwR2ZaYWtzYk9UQXBj?=
 =?utf-8?B?N0RlWlUrNSs0RWZqb1hNTFlKcis5bmYreUlPeFBMWTdYMHR5YUhRNXExMWxl?=
 =?utf-8?B?eTB6SjlsU0hBWENndWNUSjNaTEVLWklZZXFrZXlxUTBVY3k1UG5DYWIwOUl1?=
 =?utf-8?B?ZGlydlRLZ2V2K2ZNby80TDhKQ3Y0Z3BYZlZvNGFqNVY3b1kwUmhIYWNOUzh3?=
 =?utf-8?B?dmRST0FuNTRwa1VSeHY3V0h1TkJQMkJTdFd0czRXVGd4UVZlQW5uWmJtTGZm?=
 =?utf-8?B?WHdldlFIS0crNDlLYnVFelhNQjZkdUh1cGJBamV6NmRkWWdoSDRFYndGZDlL?=
 =?utf-8?B?R0J0MHBMdlJTU01qU1NSU3JLclArUnV5bUU4U0tWdnpkcEpNV3NraVV0aTdI?=
 =?utf-8?B?MkxpVVJUL3RpUDY4OGN3OUp5LytONDlPcEJpdyt5SFBDOWRwdlBBZi9TN1JX?=
 =?utf-8?B?Y1poZnpweU52d3Y3d1NYWWpUMnI3aGVHQkFTdkRRaWttV09ia1lCdVpNZzNz?=
 =?utf-8?B?Y1RzeWYxZGJGZnBIb0RFQVU0WmlVd3R0VkNScEdPdEVITHBMS0UvMlpCTC9N?=
 =?utf-8?B?MGVkandndE5uYlVEVDZjQlNvNExpVG9jR1Y2NDBkalVlTThoL21wbEcxYkcy?=
 =?utf-8?B?N2JOOFZNb0xrMU5QVXBZM0Q1dVlJNSsrRkh4ZFpRNlRBKzJOWVcvc3VVUU42?=
 =?utf-8?B?WklHdXBJLzh4SkZBTy90K3lwM2hGK3RYcWYzVHJYem5wYnN4N1hWb0FKTlRH?=
 =?utf-8?B?UHBYZFFQZGpQa3F5SWtwR2ZYc0M2QjhhMHpBWDFzTFBKNjV6ODRrUStMUHRh?=
 =?utf-8?B?QmhBbURseTl2WEZLS2dma25LK2wyd2lNa05laDdsWGRJS3pET0NDTjhJR3VM?=
 =?utf-8?Q?2Q76LjkJI8hU79HAflknd/FSXrBfs3vh39O9XBx4zIfR?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde23ef1-a0ae-466a-5319-08db676818ac
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 15:01:39.3324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxem4aLm5867qCt3qn0r4noQefttGLr5vPXOL3BlXMuqj/JR2pqBVxh1S/vFhqMQOd3iQvJNfuCXPcOyBIag7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2379
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Chris,

On 07.06.23 05:23, Chris Packham wrote:


>> Chris, could you test again with commit 0c7e66e5fd69 additionally applied and confirm that the warning is gone?
> 
> Yes with 0c7e66e5fd69 cherry-picked on top the warning goes away. Adding
> e644b2f498d2 doesn't seem to change anything (still reports that
> interrupts aren't working) but that's the same as the latest mainline on
> this hardware.


Thanks a lot for testing this!

If interrupts do not even work with the latest mainline kernel something
else must be wrong.

But it is good to know that the cherry-pick fixes at least the regression.


Best regards,
Lino
