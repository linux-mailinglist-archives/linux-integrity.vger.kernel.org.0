Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1375A85D0
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Aug 2022 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiHaSiT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Aug 2022 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiHaSh4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Aug 2022 14:37:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC3EBF79;
        Wed, 31 Aug 2022 11:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrbivl8Ph/CJBxHgxpLUkwlzv1zV7vP1HKqRPa2fJzamgY70eWeQulJnfw2RdNY0xQFa3r/2K7WU6rKLoRHYJriT7FmD5xqQhZcbJae7yFg8t5GbqkSXuKrgu0lOWuOeWznpkyN3xkfG4fIg8xYoNhhwoZp4Gd8PZfN6nrJ83vnODCzBxZGFh+5yKwtNv7yep07YAxHxZSUxjmsA2Yj3NpTvAnyVr28GRema7TGRyztNVWcZ1j58IuN4Jm+FtJuqzQk41ZDlmMZZrJmCh57AyfwKNMIKfYp6B4SCo/TYqczeZBwFB8euQ+X1I8Kp4chysEQK6VXxqIyf1po2jqM0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJSYGo1I0/k1oyjPAXi32o8gHEfwKVXFAzLwgtl9NjY=;
 b=DZMO0J9ECAlvyfOizgjSmDtWlHPfuYVbmyIDzE3H+X/LO1te+FMkAsyCQclZBYtNhnHt5SM4zr6vHUKIl7vm/GFm5m4REZ11cmcp+1ZBj4QY9MmFS6qWwYgd5eDqGBZ1r9YST2HxT2SFIp3NrL8v1OxaU8YdL6qWpbf3yroxMK7ZajXsoXEqulX95tKrVEW6qCNpK90bz5Kpu4WchuT0DWLt22iTySC/T3we8T5SlRGnQATHAlz8yH+cvlh7WH8zd5vqXpisDOxxsxYfu7CkiQYGwcH32LS+eIXalZeje93h8uipWOvzlt3GStrrEBV6qudqyC3OeeGAAZWDYyL0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJSYGo1I0/k1oyjPAXi32o8gHEfwKVXFAzLwgtl9NjY=;
 b=EIp6cx6KmQFZziP0OzTjcIVSFLAZR5PzlfRSrUE79XGKRrAO9d03hxkKsmWJNFv22WXzt6EOr9T0nTY0JbV5Of9zE/eqWXVfNkDAb3VGrVwsjVZ4e3m8NZ6c3PF9kBi5dpQc++bknq0XBAIGkSyreYFrRXygLcKH1e70q8AvlM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 18:34:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%6]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 18:34:54 +0000
Message-ID: <e74a2c48-fd30-aa4c-9ab6-eafe652f7878@amd.com>
Date:   Wed, 31 Aug 2022 13:34:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 00/10] Encrypted Hibernation
Content-Language: en-US
To:     Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20220823222526.1524851-1-evgreen@chromium.org>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220823222526.1524851-1-evgreen@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:610:119::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0bfd3ab-8380-4573-8335-08da8b7f7f53
X-MS-TrafficTypeDiagnostic: MW4PR12MB7384:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9rYLmwpBBLVxipSQeOlLctu0IyhE3/kvJKYTp1ZE6aXFJe1HSd2BUHJL4sT3CglParp+GMatpfHcHWIztbkEVfEDuip3UDJg71b7aN+xCP3o5URf2r4ADkMyG+q+Y1e8Wu9VPyBRHUIDDJuZZ24cHiO3NtpUcAz+FfcK7lzciV4/aCfp88oFewDpey408oqn5C0D8m9bj+p0UZserKadVo+NTRFmPdANxOdLmOJVTC1xxFkp7hM6TXBz4W2EVUyYgsxsM0tFh9pdiXgLM3ELHvYfiHQxt3+SqU3gd/k63Sl5gnQezhrsnuxDVOqf87gBIBTAxkg/rlASqO/yi/KfDJU3iWSEbRu2DgG7byLSI8X+0be/BD8ZQS8xWnczI04FbqOos+I2sVEWaEWZe3k5cCmS0ZTyBzbONe7gwfZGO9G5Q0QsR/IVPQPphQOLIKK/fxvF+bhVDqgml4J2B5QlQ8T2y3G4QELHDHzqhLl89y6/TptNXcZCLnGi7qeKsaTs1bZg0SM9P0M68gH9mT1Fy5x9r5n68IZMT1tmMEFqieJB9uswGln1Y223lmJp0B8nTTCcPiiaG6TZjNGygPk3HwGHAJ45Sjbk1zxeUbogoGYtYz4pT1H/1vWNVM27lABSGJBf4RZoL8AfgWMj4A7fAjpJHffDmjfJKvesdm4+ZO85zJxBXHxoTtcRGPl0LUlGGeKBtTaylIZULBprDBvTks11uUTZO8Bjv6EQd+ApxpF+5ngggPosJEBM5qAOm+kf88glPTBCjiznN9PhryUwn7zic7iVcD6aoQ15QMlVdOt/sOxe3UDlvor8koOP3e7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(6506007)(6512007)(26005)(2906002)(83380400001)(53546011)(6486002)(316002)(54906003)(38100700002)(36756003)(8676002)(66556008)(4326008)(41300700001)(66476007)(86362001)(31686004)(66946007)(6666004)(8936002)(5660300002)(31696002)(186003)(7416002)(478600001)(2616005)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3MzQVBqVzF5WStBT0tNSjlKUDIyOWFQaHRDS3dvS3dEcldyUzVUK3luUHJO?=
 =?utf-8?B?M2VybmN4MGVNdDlNZEZzdkVMRGxGc2JTbDlRTml5UTkzcVMwdTEvM2tlZUNM?=
 =?utf-8?B?Zm16c0NSa2U0bUp0bkN1QWVuTWxVakd2SEtIN0FuM1FQTnFHZFc5OVJpd1pC?=
 =?utf-8?B?bmZMb2VSbDhmK01rM0NZR3BUd3p3M1JpbHVtdzJjNjNHLzdSZytRSGJUT0ZO?=
 =?utf-8?B?TmtyK1FJUG1MNGN1Y24weWxwMmFoWTNOYkMzcDhyTlgzTEk5YXVVcFZZU0g0?=
 =?utf-8?B?ODBLdnh3Y3R1WkRmSEEveVRxcWMyV285djR3NUNlMzFoY2FEek4wT1NhbVA0?=
 =?utf-8?B?VEVPZkhqZjRsZE04ek52a2RsUHkxOHI4OHVWT2NycjJDaWRSSGZCWkhmallV?=
 =?utf-8?B?dUdnUDNRV2g2eWVPbUxweThGNnBrWnJ3S1VEdi9odGNndXdCeUZzNUlnRGdX?=
 =?utf-8?B?cG9sdkh1NjhrYi84NG1XdFl4UDJBcmVYN3Mzem9MWnJzOUpxUG9MQXFtTmwz?=
 =?utf-8?B?V2xLUGZ6bjZvVzZGTytkUm9kMmd6ODBNMUNReWRQMjhWTHBPZ29JUU9kdFhn?=
 =?utf-8?B?b0o2bUN1MUpBN0RubjdoSk9lMmJIU3UxZnZONkVoR1lXRVY1ai9QdGwrN3JW?=
 =?utf-8?B?dkVtdktoM1dMbnpxREJRdlNPaU91YmRxcGIzQ25FLzBwWmdiZFhCNmtYN0tm?=
 =?utf-8?B?L1hrQkIwSExmQUd0SU5MN1E4M3hud04zaVBuU1pXSVdrUUxiMXl1cDZ6NHFQ?=
 =?utf-8?B?YStjdzhTTFFjK1B6TFg3ZTF4WVZDak5hY0RyK2NnSmxOaDdLYyt6UFl3ZzY0?=
 =?utf-8?B?cmZOb0pDWlJ4UVBVNkh0bDMrZ1dPNlNGM3BCL3M2ZDJPck9iZVNnRnhyNlRJ?=
 =?utf-8?B?R1hHWWlFbWFMWEg3T0dKdXpaSVZYUWVDY0xoUFVXc3JnYWZVQXEyUjJJcXZL?=
 =?utf-8?B?UTU4QmdFN1h4TnowcW44SUtFeVRmTGdTdGRUazl3bnpiMjBqM3g0ZytWYmY4?=
 =?utf-8?B?VjVzaC9QbG5Vc2FRYjhDT0czZ0pqWHRKRUcxQUdGVDExekE1ZUVFZGJCMXdJ?=
 =?utf-8?B?clpmUnFMait0R2hMM2xpZ2ZrckhaRmJjeVJkeU9PU3F6T1lnWjBJN285T2Uz?=
 =?utf-8?B?UXBvRDI5NnZOcCtVdGpQNGFTZE5jSkxjaE80TDVsOGNRUWlBeXpkQm9FZllL?=
 =?utf-8?B?czRWZy9HTDZoejVyRW5OdHRLeHc4THpIb0xRMG1VYldSQ3VGVHoyWXk4aU5K?=
 =?utf-8?B?eDJtNll2T2h3R3p1eGRaNFEwMkZkMnhBYWh5T1crMlFPN1dYQ0hGamV6dnpB?=
 =?utf-8?B?ZDdxT2pxOUlaY1B4SFdxdUJ6WUVqNSt0Uk9wSDM1NC8vVTNMVldaTy9zYnJz?=
 =?utf-8?B?MS94TUYvMGtzU0JFV2NPbWJZeGN2TlRnMlg2dG5PcHl6VXYxbzZrTVpReHY4?=
 =?utf-8?B?M3RoZUtzOEgzdzN6U2VnZmlHb0pMSTBhakszcVFBTUlGYklJLzNycXgyMGsx?=
 =?utf-8?B?aENPdjJpZWpiMXpTZkZ6UW5Vc0xTamZwWmxwYjl6WlVOTFE2ckZHZHZLQzln?=
 =?utf-8?B?cFJRcFBDbW1rRjFLNGUxQloyeUtuaHcwUFhrNEJrTGJQVkNITnc5bG5UbDFJ?=
 =?utf-8?B?M2FoSldTcTlTczRvTXBVTEs4STJmYTRZZjd4QTZtaU9WVkdhcDc2Z2RIS2RF?=
 =?utf-8?B?NU5SNXRXVFVHYnJEbFpsZHk1Ly85SVgwMWtQQ2JZMFFRUmVNcURwdjJiU1pp?=
 =?utf-8?B?R3VlWUF1dmUyQlQrclBxVWQvVnk4bTMzMjJwZ21RZXJtcUpGRlZQMmZ6c0t2?=
 =?utf-8?B?NXhUT0l4NE0xdWh2eUFQd2FSVXdLRUlWUlNCV0V1aFMrVjNUVzU3RGI0VUd6?=
 =?utf-8?B?NjJHNEFhZzVVdXVwYWhUb3JPUE9JOGUzYTdlN0JFUFh5RGVYVENKZGJ4dDh2?=
 =?utf-8?B?clJCOHVFZTBzK1FyMVZ5NDR6YkJWRXN2WE11Yzd5MUpsMzBlTTREYUM4MHd5?=
 =?utf-8?B?bjJCRjhQdGpOL0xUejV3YjYzVjZ4TkdjV2k0aWFqNVdmb1VKc29RaThLT3V0?=
 =?utf-8?B?cHVrNmo3WXcvSlZRcWo5K0hCSitzVWxVVTBoVE1QdzNPbUczbU1hZElBOGRy?=
 =?utf-8?Q?7muGg2gemYp7Vfs9nijsKSZE5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bfd3ab-8380-4573-8335-08da8b7f7f53
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 18:34:54.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jb5la09YpnyqxQ+MCQuVymErwR/3KlATGVMRfDi2+20GPsU1lZ1SoHtITDqs/qvMl2LYWS9hjsJbdmaJDk8Hng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/23/2022 17:25, Evan Green wrote:
> We are exploring enabling hibernation in some new scenarios. However,
> our security team has a few requirements, listed below:
> 1. The hibernate image must be encrypted with protection derived from
>     both the platform (eg TPM) and user authentication data (eg
>     password).
> 2. Hibernation must not be a vector by which a malicious userspace can
>     escalate to the kernel.
> 
> Requirement #1 can be achieved solely with uswsusp, however requirement
> 2 necessitates mechanisms in the kernel to guarantee integrity of the
> hibernate image. The kernel needs a way to authenticate that it generated
> the hibernate image being loaded, and that the image has not been tampered
> with. Adding support for in-kernel AEAD encryption with a TPM-sealed key
> allows us to achieve both requirements with a single computation pass.
> 
> Matthew Garrett published a series [1] that aligns closely with this
> goal. His series utilized the fact that PCR23 is a resettable PCR that
> can be blocked from access by usermode. The TPM can create a sealed key
> tied to PCR23 in two ways. First, the TPM can attest to the value of
> PCR23 when the key was created, which the kernel can use on resume to
> verify that the kernel must have created the key (since it is the only
> one capable of modifying PCR23). It can also create a policy that enforces
> PCR23 be set to a specific value as a condition of unsealing the key,
> preventing usermode from unsealing the key by talking directly to the
> TPM.
> 
> This series adopts that primitive as a foundation, tweaking and building
> on it a bit. Where Matthew's series used the TPM-backed key to encrypt a
> hash of the image, this series uses the key directly as a gcm(aes)
> encryption key, which the kernel uses to encrypt and decrypt the
> hibernate image in chunks of 16 pages. This provides both encryption and
> integrity, which turns out to be a noticeable performance improvement over
> separate passes for encryption and hashing.
> 
> The series also introduces the concept of mixing user key material into
> the encryption key. This allows usermode to introduce key material
> based on unspecified external authentication data (in our case derived
> from something like the user password or PIN), without requiring
> usermode to do a separate encryption pass.
> 
> Matthew also documented issues his series had [2] related to generating
> fake images by booting alternate kernels without the PCR23 limiting.
> With access to PCR23 on the same machine, usermode can create fake
> hibernate images that are indistinguishable to the new kernel from
> genuine ones. His post outlines a solution that involves adding more
> PCRs into the creation data and policy, with some gyrations to make this
> work well on a standard PC.
> 
> Our approach would be similar: on our machines PCR 0 indicates whether
> the system is booted in secure/verified mode or developer mode. By
> adding PCR0 to the policy, we can reject hibernate images made in
> developer mode while in verified mode (or vice versa).
> 
> Additionally, mixing in the user authentication data limits both
> data exfiltration attacks (eg a stolen laptop) and forged hibernation
> image attacks to attackers that already know the authentication data (eg
> user's password). This, combined with our relatively sealed userspace
> (dm-verity on the rootfs), and some judicious clearing of the hibernate
> image (such as across an OS update) further reduce the risk of an online
> attack. The remaining attack space of a forgery from someone with
> physical access to the device and knowledge of the authentication data
> is out of scope for us, given that flipping to developer mode or
> reflashing RO firmware trivially achieves the same thing.
> 
> A couple of patches still need to be written on top of this series. The
> generalized functionality to OR in additional PCRs via Kconfig (like PCR
> 0 or 5) still needs to be added. We'll also need a patch that disallows
> unencrypted forms of resume from hibernation, to fully close the door
> to malicious userspace. However, I wanted to get this series out first
> and get reactions from upstream before continuing to add to it.

Something else to think about in this series is what happens with 
`hibernation_available` in kernel/power/hibernate.c.  Currently if the 
system is locked down hibernate is disabled, but I would think that
with a setup like that described here that should no longer be necessary.

> 
> [1] https://patchwork.kernel.org/project/linux-pm/cover/20210220013255.1083202-1-matthewgarrett@google.com/
> [2] https://mjg59.dreamwidth.org/58077.html
> 
> Changes in v2:
>   - Fixed sparse warnings
>   - Adjust hash len by 2 due to new ASN.1 storage, and add underflow
>     check.
>   - Rework load/create_kernel_key() to eliminate a label (Andrey)
>   - Call put_device() needed from calling tpm_default_chip().
>   - Add missing static on snapshot_encrypted_byte_count()
>   - Fold in only the used kernel key bytes to the user key.
>   - Make the user key length 32 (Eric)
>   - Use CRYPTO_LIB_SHA256 for less boilerplate (Eric)
>   - Fixed some sparse warnings
>   - Use CRYPTO_LIB_SHA256 to get rid of sha256_data() (Eric)
>   - Adjusted offsets due to new ASN.1 format, and added a creation data
>     length check.
>   - Fix sparse warnings
>   - Fix session type comment (Andrey)
>   - Eliminate extra label in get/create_kernel_key() (Andrey)
>   - Call tpm_try_get_ops() before calling tpm2_flush_context().
> 
> Evan Green (7):
>    security: keys: trusted: Include TPM2 creation data
>    security: keys: trusted: Verify creation data
>    PM: hibernate: Add kernel-based encryption
>    PM: hibernate: Use TPM-backed keys to encrypt image
>    PM: hibernate: Mix user key in encrypted hibernate
>    PM: hibernate: Verify the digest encryption key
>    PM: hibernate: seal the encryption key with a PCR policy
> 
> Matthew Garrett (3):
>    tpm: Add support for in-kernel resetting of PCRs
>    tpm: Allow PCR 23 to be restricted to kernel-only use
>    security: keys: trusted: Allow storage of PCR values in creation data
> 
>   Documentation/power/userland-swsusp.rst       |    8 +
>   .../security/keys/trusted-encrypted.rst       |    4 +
>   drivers/char/tpm/Kconfig                      |   10 +
>   drivers/char/tpm/tpm-dev-common.c             |    8 +
>   drivers/char/tpm/tpm-interface.c              |   28 +
>   drivers/char/tpm/tpm.h                        |   23 +
>   drivers/char/tpm/tpm1-cmd.c                   |   69 ++
>   drivers/char/tpm/tpm2-cmd.c                   |   58 +
>   drivers/char/tpm/tpm2-space.c                 |    2 +-
>   include/keys/trusted-type.h                   |    9 +
>   include/linux/tpm.h                           |   12 +
>   include/uapi/linux/suspend_ioctls.h           |   28 +-
>   kernel/power/Kconfig                          |   16 +
>   kernel/power/Makefile                         |    1 +
>   kernel/power/power.h                          |    1 +
>   kernel/power/snapenc.c                        | 1037 +++++++++++++++++
>   kernel/power/snapshot.c                       |    5 +
>   kernel/power/user.c                           |   44 +-
>   kernel/power/user.h                           |  114 ++
>   security/keys/trusted-keys/tpm2key.asn1       |    5 +-
>   security/keys/trusted-keys/trusted_tpm1.c     |    9 +
>   security/keys/trusted-keys/trusted_tpm2.c     |  304 ++++-
>   22 files changed, 1754 insertions(+), 41 deletions(-)
>   create mode 100644 kernel/power/snapenc.c
>   create mode 100644 kernel/power/user.h
> 

