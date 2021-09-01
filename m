Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750753FD118
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Sep 2021 04:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbhIACNm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Aug 2021 22:13:42 -0400
Received: from mail-dm6nam08on2089.outbound.protection.outlook.com ([40.107.102.89]:3560
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231249AbhIACNl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Aug 2021 22:13:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbe/2FQ7glNzmDNRp0zaju0Io1MQ8QC14em9PItakvBMJqUpLRoZFpfrdGRBqPu3oUf44RjacGN8HVk4pb3tDDAPXyPidtnnL0GTnY4E1siqSPvk1Fu8NMtUu1HlWMQOorwJI+IoO9ESG6sfKNp9oLUhzSAgHC8kr+SiTv61cRM1CA6AJGhh0dUxER674qV4ZpL+uAUJl6/QcvXWXsFXbjsFxtHknzt+Uzd870eCLX2xxU9erfPR6FFJfntRyrKrGOH3QC+jPgYFr5opnDf+dZrYJZW4ybGOhjKVcJ/2BpEy6XK36hxps+2zLI9PA0VScmFJEmQaFAYv6UR7nAuKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=v/bh4uwbJvUbiW3BJ6IO4rmjPT1zMHUV+1Mu+V/7u0U=;
 b=kBI9zzwxyfCK8d8nuuP92NSBhpYxXdpPc3/6jACxGOyfVCyzUstlToJ0K9x0BzkDU2TMvE+oUV4nEDlBq3TXIXExHqusSYuOaNadlK03jd2l4JZujbe2b9BgcUmg2DhxF6QgsK+2naaB7Vpx/zHBrJv8sh5K6KcRPX61BhmFjCUaoJDUP7Eza4UBCv0MqllexirL523pxU/BG3gx1V8pPUMFzXKG+ygGk1Nz8AcGn02qnVNyPoShD2aB7Fr5Rr9yblPuU3gu3qWuuIHpJI48nw2QnO1g8zpysM8cMPeamto5Tmhh3eOswRQLTmq9mbIKsc0hJ2k0rOgWIhcsyzsX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/bh4uwbJvUbiW3BJ6IO4rmjPT1zMHUV+1Mu+V/7u0U=;
 b=phvFkBRzMYxQ7rbChD69DYIrulCz0wgXaf+X1T9sw7t0m4n7byPYX3iLMys4evOGTBc+92O8ncIpg2Iaseui2vyp8BYxUabUsWoj+yYsWpdbfr64eXVEzsnNp5ESnkRsw4aK8ZjDkKuX+bBRCLWvcbvaMpGmZqB3q4ce+4IEaW0=
Authentication-Results: vpitech.com; dkim=none (message not signed)
 header.d=none;vpitech.com; dmarc=none action=none header.from=vpitech.com;
Received: from DM5PR07MB3975.namprd07.prod.outlook.com (2603:10b6:4:b3::39) by
 DM6PR07MB8144.namprd07.prod.outlook.com (2603:10b6:5:20e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.17; Wed, 1 Sep 2021 02:12:44 +0000
Received: from DM5PR07MB3975.namprd07.prod.outlook.com
 ([fe80::b000:3dbc:a50b:1261]) by DM5PR07MB3975.namprd07.prod.outlook.com
 ([fe80::b000:3dbc:a50b:1261%6]) with mapi id 15.20.4436.023; Wed, 1 Sep 2021
 02:12:44 +0000
Date:   Tue, 31 Aug 2021 20:12:41 -0600
From:   Alex Henrie <alexh@vpitech.com>
To:     Alex Henrie <alexh@vpitech.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        alexhenrie24@gmail.com
Subject: Re: [PATCH] ima: add gid support
Message-Id: <20210831201241.a256fa28b510a8e2546be79a@vpitech.com>
In-Reply-To: <20210702222027.13973-1-alexh@vpitech.com>
References: <20210702222027.13973-1-alexh@vpitech.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY4PR01CA0001.prod.exchangelabs.com (2603:10b6:903:1f::11)
 To DM5PR07MB3975.namprd07.prod.outlook.com (2603:10b6:4:b3::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from demeter (66.60.105.30) by CY4PR01CA0001.prod.exchangelabs.com (2603:10b6:903:1f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 02:12:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 822eb616-1341-4a58-545b-08d96cedfb9a
X-MS-TrafficTypeDiagnostic: DM6PR07MB8144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR07MB81440E6730CB6E53F59E8989B8CD9@DM6PR07MB8144.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yt3TzKME6jKbtigi3jvWubbJeoD/tES3s2LeigTc025ac74wUDDrCZTIxp37jI07e9qKOz0j5X1W+GZqjHs8UXi77z4o9ksMxW3UZtXeevqmQiEI8uofeEjT7fFJo8Ys5pqxr+3g0HxmiphFQfzOiac2x2AZcrHHtXO5lnFxqx91YU8zrG5pgJBxWinAwvsyCu9s2CaMGDShosaGoezUs2yW4Onl4B75ofnUTyUPa23e8tdHz7wxwt6IDlOBh143ceU/5OUKeLGXotnWfKX+X1cH6/yoIMKweVHBRZ6jComsRnQ+YPfHOrmzoZK8/Xs1vPjVK5rgKahBCmOz25IvPHEfEALsOINjr4OOmoq+bhn2ddelPgH6CFHMkNh6rqkuYamwlCRp29pFsgczmdBC+aWnZDV+4HqC5lU0ZWiJKxNwRS0nQ9jctX00i287bNpc54J3YQS3oPQqpQS/KOFwpLIJYLeqYjPfK3GJhWSp2bMJTeyhtgvdm+dxsDZrcqbZf9HTAjzMTayKp7urzTcJl3WHsdGv+nWeufPaWsydAP+SbJ0A8hB3qapwhcCJaY4GeMSFGFoEyn7rlg8lhA97aV6Re4BB4S7RN8pPvY0MMtwi8Y9pBvYkSrRtxZ5bXMDt5vrgKg15SH2FafEpgSD2nPfB5SrPpncPnnpVtpOaYLfSpIxoSUBz4b/BM2NQLafE56NTX1zrtttpSSb3GNVvDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3975.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(37006003)(508600001)(5660300002)(6486002)(6200100001)(316002)(86362001)(4326008)(6862004)(558084003)(52116002)(26005)(66556008)(1076003)(66476007)(6496006)(186003)(2616005)(8676002)(36756003)(8936002)(956004)(2906002)(38350700002)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c/YV+BXMnvzFDqiIWwrqJ9AbA4Alxr/ZNBK2tZVF+Jn6UolmUGo4KCwT9dij?=
 =?us-ascii?Q?h5cbOOruRMqEApkrp2YnRdQMPSaUlL0C6q6JUiGCdKQERE6TL/gwv2AhoKpf?=
 =?us-ascii?Q?0Z/e+CnrJ7AyksU+Z7L20f6qBH/wC5IU7HyiLQWxAOF+SQ7RazKrhyNn2wRu?=
 =?us-ascii?Q?sjWLqYn7aWAyn0wQCgcSiZfLmMFx8ySBXaevNUhU2NZwpXpvfGRMwP+EJoeN?=
 =?us-ascii?Q?QgbnmOJIYQ71SCmMMHanAz7PyNjZK1IkAR68YQyKiwhI8sNkALbGQ9Z4vNGV?=
 =?us-ascii?Q?znUC615VDYAQfK9CAwysUAlVAAvibBgUbkjztKdQ+b1qt1hO8QKIi7itTj0V?=
 =?us-ascii?Q?5Ys7lfy8m9LWk/IWfmF6tCB6W/lodFvI1N6kcJS0XP/RZiKOesMOxCmAqp51?=
 =?us-ascii?Q?4a/sV91/sx+iXsvKDlxntUbcKREceW18wqJYuSJzuhz2jCvmQ9xtDylzTC5z?=
 =?us-ascii?Q?sLHmP6mHBcTei9sy5Vudbxbw7r/g0p5uYSguxenTskoANOiKfQh/nU5Q47yF?=
 =?us-ascii?Q?TWseexGx0Tx5O/kCzIJ/DSbPqunFmDWKRVszfOfSOvfgnO9p6naRjkTrjtW5?=
 =?us-ascii?Q?AO+CbF6LPfJTalMWQaSZQtbTbH4IGdIS5cGnzQJUhKyJvXJO0bkelK24vRV2?=
 =?us-ascii?Q?Y4KIkSNq4h8Du+/LRzvR6id0xa/SsN2sM1KbefwC5iFMpcG6TlKYSXIuzxpD?=
 =?us-ascii?Q?JBAkpuhFFdTSVgMtb4c8xFKxDPDuLkDWTGWvVzAvdttEofCfakMYopbFMpW6?=
 =?us-ascii?Q?qJ4k6vN2a5ccA8o32nogIhV4dwuVgM9J7m5i6HnNPUbTKCnYOsqlnN9MNaXP?=
 =?us-ascii?Q?fsnmj/PGsoPQWCyL/5M3nDGSSi2oEWot+J3BDSK+mIs/IETFHTV5zNV9Lwrw?=
 =?us-ascii?Q?s53H3ZHuVqCtBfXCHSMc5rxRvLEIp18DD1enM21HP9ED2p7/EXg4Xa6uBj8X?=
 =?us-ascii?Q?7yzNVXJPESOql6rtJUxlhThrna3W6/uixlfgF1S6Wv7zYV93R4TcxrFzNCyT?=
 =?us-ascii?Q?H6plSpsu1YhNPUKGKQaksdfUDbtlSgd548pnFcOL02qOmN6IFnK6SxhFTVH7?=
 =?us-ascii?Q?StbvuMSbqSNhnfNG1cRaPk/c9NOrPeAmEvMG1/9+/EePV2l6+bZQXwjHj6UQ?=
 =?us-ascii?Q?nQ1VgpoPhhzhtByPP4eoL9qnqj7LA1SuCkSEn4OQCWeqF1qeBJjnO02UN9Jb?=
 =?us-ascii?Q?nS6VcSolPYdE7Tl7vAZDMWJ9S+avAJmzUYrRdyqTC27ekoojNXxFys8mSJHS?=
 =?us-ascii?Q?KhDpnRsGkqvZirtePXeR0MBB1EkizixMi/ngVi/piVPMicVlB2IJM8i5Cbwy?=
 =?us-ascii?Q?hzNeB3B+Lsqa5v9xhHIUMgq3?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822eb616-1341-4a58-545b-08d96cedfb9a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR07MB3975.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 02:12:43.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLnf2hl7WRjc/KMQ6+ThiV4uZKPdWNnvDHUcH8iu6oa2nF2r5kgg88aYghaBq9+FlxPiFxG+V6GkzQVqOUnOsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB8144
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello, could I get some feedback on this patch? Are there any
objections to including it upstream?

-Alex
