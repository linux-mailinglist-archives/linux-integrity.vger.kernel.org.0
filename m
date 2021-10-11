Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82983429805
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Oct 2021 22:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhJKURb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Oct 2021 16:17:31 -0400
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:37601
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231926AbhJKURb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Oct 2021 16:17:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCst/e7F7zllkKA62ak8i8nXXKHWp8tISakpYfoNx08m6yQ6pFx1TGOdcu2+fOBv7SX6ZIj5dFdI9b0AQkV4hifAajRU8jPP1027Y8cTJQW/P0VivKkZlVm7QuykEL0GlKvKRVyWDarefEDE0vhktLTF9YjwWaimDD4HA2UfAFqlK8UIs0/DSYylKt9NNWi7Ghf0uNo/6NvJmyhq88UN04UiScAKUmYMv8rvYx6zFwCkInmzwKUQkNlWwitoD+vzwEtQeFQhmVjH+EzepcMpez+mINb6QVGu68gg9wR8leTYGTqpeXQQAxErjByqdasy4nCFLaRc+EvfT2Za2ujNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1clS2fPc/maF1pH4AImXisN8cROt9nrGvoM8RnZCHeA=;
 b=cEGh3QgtdGyJMWbYq/EOzulU0PyeIAhwByGSljWLa9oG4uduR/mhRX8tQTElpCMv1KtxusWWJZpoYwUOY5LcnMyIlZGXiVlJ41DsOl8EPrCFGs/oDSbydXYB7/VYHIFoUDR2N1CmhWKcT7Sr0owWwgNHAQw7QKMG1rW+a/hBAH3pDNNsL1CJFeYbCXO6xSZlF2PW+xTlO5fZEtIHnH/pjcQDxpB/KBIi+waAJ079hDwv1IpPN8hcjtWvoJm6cH5/GFUVyRhIsia3sLt82c1yZYK8ljC4NCZWcZI/rLq+QTGRd+FgDc1Zts/bywGb0EWZA3YfkV2UTAgyyGRtNGr5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1clS2fPc/maF1pH4AImXisN8cROt9nrGvoM8RnZCHeA=;
 b=n2N3y3A1iPv6DJhvlh7pgPeKh5nIrnUdOgmhunnkdE2K3sXqhkDSfHH2VUZUrgSH+PbElFKdkF6O0itY4Tf2POETMgBC0GJJKm1SJ+eLzO3ijeQwt75DVUZZo1eO8x+N8Ztcy3pa9VW045jQM0PIvm7g/xqzjt6DjOG1J48nxfU=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MWHPR07MB2879.namprd07.prod.outlook.com (2603:10b6:300:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 20:15:27 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 20:15:27 +0000
Date:   Mon, 11 Oct 2021 14:15:23 -0600
From:   Alex Henrie <alexh@vpitech.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        alexhenrie24@gmail.com
Subject: Re: [PATCH v6 0/2] IMA checkpatch fixes
Message-Id: <20211011141523.23e11a969c294d83ca6c3af6@vpitech.com>
In-Reply-To: <685eb07ebb22de45a0b15c82fe7b8d56431269ce.camel@linux.ibm.com>
References: <20211008091430.22392-1-pvorel@suse.cz>
        <685eb07ebb22de45a0b15c82fe7b8d56431269ce.camel@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:303:2b::30) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter (66.60.105.30) by MW3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:303:2b::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend Transport; Mon, 11 Oct 2021 20:15:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9501df1-674d-45f7-eab4-08d98cf3ddb7
X-MS-TrafficTypeDiagnostic: MWHPR07MB2879:
X-Microsoft-Antispam-PRVS: <MWHPR07MB2879B2A1D888EC9E99A77941B8B59@MWHPR07MB2879.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUxmz/GuHOMpm3Dx0VFFBiVNSJ1QbyCQ05MflBbY3CvrzB4hQd4ug0Vq2Dxa1ymy4vXlcvAGquGFlCFLpkAVnppMwF/aGjVIeDZI8sCoP12/o+Sxz6SWuoWOO979m017sSlc+5v4r4QFfrdmW7sH/ZkAfdjJkeca3yJ2Q2WxMV/+I6GopIRkSeOUWIcbtB/wY7Ci2eOdbIfT6XojU3Vy7m2VCmAbyQKPFBbtuRGPjzKhL7McBuGyiT9paMAKvnhT3MNl532VV5ZARwGhL7oKqIE63ff2CqW8MvFPsdLAGzOiK0AH3b2P7/HpUzAbI7XiGhzwN8z03lFODjahQ6HYWeh7td/OoG5iv4jJxrkPvWjpDEYX75a0EIs/JI2kIJHEB3Nn/NjOAEE/O3Vy/0p5XmnXN7CQ75omUIPf0f3O5vyJB/tWfUd2Q+lXojqP2Ij/QaOsGZEYJJESSHpUS5yUrmgfKonG/pzCsJh6lnairNG6RpWd8iLloXFFzAVc36UzpFsXOoJ4YIl6QySMkj0UVsLd8rcwSrU7OLtlnnhgvfuOwPavE7atktyp/wbbB5GKo3bLFZvRxRg1yiMj7OValDrN7ncEy4EgyLXm3BVW2A0p6WpY5AQLvfXf0ElmYY7iMbefxHPzpmbLIJoC3IfYZazzdZPzDDbq/RXuZuhu3LkbKrcVw+J5VZo7zcXg7IvtOHUjmOnQVr65lzmrkiKQ5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(39830400003)(396003)(2616005)(66476007)(956004)(6486002)(8936002)(4744005)(66946007)(86362001)(1076003)(8676002)(66556008)(26005)(186003)(5660300002)(316002)(38100700002)(4326008)(52116002)(6916009)(38350700002)(508600001)(6496006)(6666004)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O7BXvGXP7xifAQuWeN9IsA96tm66Y16B+qgzXQk5obw7HM5PcmAre4ohu224?=
 =?us-ascii?Q?Ba4YEabhM1apUhoArC4oiXSBqpYPypIwVZj215BO30iW924BxjEifh3H6D0Z?=
 =?us-ascii?Q?JRFeG16H2u/aWlFrItwZS4siLahiNYj3HPNVaTtoAyW/enOtr8KUeNmc/wmb?=
 =?us-ascii?Q?f46iMXNsyfKZwU+rEgSkF4DKFQgZCpV+DZ/0CuA2b0AhYzE+U1Tibimy43yR?=
 =?us-ascii?Q?k8ikNr2pJatjLRHfKg5+wlK8zptmhklL6pQFsXRd5AuJDyXtQJwl4Wq6bL3R?=
 =?us-ascii?Q?9ClYUcXl+pTopV2LW/Jp3guz/LLexyWtcsKZ/wYg+jbPOTmrCMBeetmyGkQb?=
 =?us-ascii?Q?aFnwr/uSKY1eUw9ifyCbs9vNHvYoPDCq6lpUPEu6hAnhjII4mtu6nVVZjmfl?=
 =?us-ascii?Q?5MuYmQJXv5cwHSbWA1kqaUb6dB0GC59JsdRH+5fH9bMRJ+NnqwuOYMhJM97+?=
 =?us-ascii?Q?/+n8+ExnDuuHmP1LfZQePkP+Ht1cpU1BqYf/xxICCEJLi8NBE0R9OG71fdBp?=
 =?us-ascii?Q?c3tbG5XM8gEnMRjP5nOhndE+9oaZeGYyJFb5rzzCRCTWyispoF49l0jJYn9Z?=
 =?us-ascii?Q?4i5rLu2TDO5Nv+gXmlgxPULhdC222yIkOBzNV/sIdigc1S6buMV7PCP6yoWt?=
 =?us-ascii?Q?o0vR2Wmo/Yol8DlKRINsVkYmnqJBnbIzcVgFgHK7NBKB9B0wqQ97aT9v+4sY?=
 =?us-ascii?Q?jK9sOEuw29UTkM0G/R9g6moEqN5T8oBWKonKuou2fFrottugwOz62bzfKrR6?=
 =?us-ascii?Q?bkd0BPSg236symimHNWqrbJP9bTzi8e6C/LCWOO0KmA04VIA5V9hC3SJYbXa?=
 =?us-ascii?Q?2OTbUbObeq6SEIZqErjktm/NbDlyQ919S+KcfMH4EJVF8hyE3xJz53iFpsQZ?=
 =?us-ascii?Q?vejnG2AQ34YDm8t+aurugBomKVc0TW5sgrWsNqJVpOEL56xvmMF9Wt3gG9dN?=
 =?us-ascii?Q?9Ett82xnU54ASfq1iZkh16n3+DLmKG3IzObirYKGIDPklVU2iaHYy//BAWiu?=
 =?us-ascii?Q?11qJ8mCVsLp+j3qvMqQ2E0BAz84gS+6HG6d8CIu6F2etXU0OtyxP3Wv/1zVH?=
 =?us-ascii?Q?JPROB24Xpf0njagOsUyHVcvW/JpFPZ2OMQrUNxQlULaHylaB3x7d4ridbHMo?=
 =?us-ascii?Q?Tj96zdckpW64rfhZ4d6wfF9H0hJarzPxbTbz8sVA4OtQr1UvoiJSCvu//1nM?=
 =?us-ascii?Q?4dIAloed9jhAmA3ikxcVVN3jV1Kl+IXvYlY/6nBswJCmipWq9ZRSIVwzdkXb?=
 =?us-ascii?Q?83DXFDfnyabzHcW88bObBd3o8vldsRi9kXQA2+qCXm7dM81GoOHSV9y3S/R/?=
 =?us-ascii?Q?2IKRD1+iL9l30YpwvEjTujfP?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9501df1-674d-45f7-eab4-08d98cf3ddb7
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 20:15:27.8023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8TwWRptH46qvom4/XQbZPYATbDNPQ/Azw9QVXXEcFHcpef66x+MHSVyK9raP+AqVrE5MgR1PyznM9fj7eAL6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2879
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 11 Oct 2021 08:08:01 -0400
Mimi Zohar <zohar@linux.ibm.com> wrote:

> Hi Petr, Alex,
> 
> On Fri, 2021-10-08 at 11:14 +0200, Petr Vorel wrote:
> > Hi,
> > 
> > very minor checkpatch fixes based on [v3,2/2] ima: add gid support patchset [1].
> 
> These and the original gid patch set are now queued in next-integrity-
> testing.

Thank you!

-Alex
