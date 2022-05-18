Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1790452E41A
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 06:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbiETEwy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 00:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345438AbiETEws (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 00:52:48 -0400
X-Greylist: delayed 1141 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 21:52:43 PDT
Received: from CN01-SHA-obe.outbound.protection.partner.outlook.cn (mail-shahn0098.outbound.protection.partner.outlook.cn [42.159.164.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B5F66C8F;
        Thu, 19 May 2022 21:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiHJToKjSVX3nTTrOixxhqFM7tq2m/9Pa2T0FPaSBxh+RCIwPM87bOEGg2w6/vOlqrfk85dPi+jiLYohbY0g6RKG0z8cXSv7zR2PdQ2XGbhQ5QqzwjkenzaWJ5yMjhqKPSMJhqGTp1l6zgBlLP47Wn9tmetTW23JX6wSoopa3TOw+/b6zA71hws9hmfEF07x7nBA/C9EbxhFp9mjQwOXWZ0JQlw4yzykons+aq3Xj+NYQpbTQ0QA5xRgC7Rz/Qn/PDN6IFJ+11EMtrxSXbAYFTyLtfLMaonfij00TCegHj5QKkA/iAkQaafsGo6uZQJq22JbDQ1ReV4q4rfMZzaUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=eas/B2CIFJUUNgvYphL8aPf4q3FRWs0P0HBrBSuPjBj5V6fHjYbgJ29+rs/0Z70m9Fxxi3x4c0dpjgwIUgsv89EUp/LnVdF1oH8DSuu+DrMVmItaowVfFWyVIIzXbOTsDKVxlaMz/EhQ62JQIZJ5GkxLacYsGcbuClJzao5wZuj7MRzya6vfMUR+SwjrA4zh32Cecc3UeumKSBXuY2TNsTl8AhoycvW+6nzHy08XIubG17+AUWBv+fyTOaSKhFB5HHxyYodgol4L0y7myiqceftADV7NO8Hlxy7ox6vWjFPbHUN+PC19uwxHU9FNb95aLQDAzR4fMYS4JAdv7mongg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=Pq/uj0sd97BXoYkVVNRH/H4HSdJ4l9AHlNCtdPklcCwxbdLcOCDbwLc7uipnQBlHn+b5M8Dnjx5MOa/suG1ODjkacYZpU+OaWHEecQ4qaATGSRVGZ0t7MeHOtj+lUHiYZocnKtFDWdEa4avAk4GwdXbyCkaE2OUAsiTk7bhxl9aN45Y3QNSj7D6rnhMir3MB/KqYTd/Fj2o4Rh6Ybk2JUMXmluA4jlPi0NKjPJsYdQiPXd4uNvAgkvVExm/59dXC4YajkYdikWviy4sFcnNf12ia7YUFF5+kV+MW6o+9t5mjd9cfxYOVC/QbCnHzW3sHOZ+lnrC1iwNmOGb4wAc1rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn (10.43.110.19) by
 SHXPR01MB0608.CHNPR01.prod.partner.outlook.cn (10.43.109.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Fri, 20 May 2022 04:17:56 +0000
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19])
 by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19]) with mapi
 id 15.20.5273.017; Fri, 20 May 2022 04:17:56 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ree
To:     Recipients <cuidong.liu@gientech.com>
From:   "J Wu" <cuidong.liu@gientech.com>
Date:   Wed, 18 May 2022 21:19:08 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: BJSPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (10.43.34.157) To SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (10.43.110.19)
Message-ID: <SHXPR01MB0623927F7589F2E9D674399E89D19@SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed228b4b-55f4-4343-e05c-08da391419c1
X-MS-TrafficTypeDiagnostic: SHXPR01MB0608:EE_
X-Microsoft-Antispam-PRVS: <SHXPR01MB06088088B61351692458919889D39@SHXPR01MB0608.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?nWjAc+C1ZnPOhV3W1u9TXGkf46+u3v4Gr5qK40RYAGxvpGwbHhcF2SHpUQ?=
 =?iso-8859-1?Q?+yddZ25qSY9rbnWTAvtnXSyC2A8iintq4CumskAzjmyr4b07jO8CWq6xSP?=
 =?iso-8859-1?Q?1vdXpBq8Ut8qc9osKMqmKn9LUF+8xhZbEPwgqZD+/era/ro2OzqDTdcZz0?=
 =?iso-8859-1?Q?jyFeXZa/lQZQ1Nrq1f5DdMKwYqGfdJkDd2NSCX9MpbIckcTS2ZqnK60pRj?=
 =?iso-8859-1?Q?cIVNv8dcQYy9Xl7TBYDzgDWhvfxoEFYMZsFOK/+zEphXdOHW1h1D0DSsmL?=
 =?iso-8859-1?Q?k1hDsE9ss0zxEfqB06oEJrqBeCGPMsLaElLf1h9qHxz7WdEMuvuKUpN3MI?=
 =?iso-8859-1?Q?tBUB24EcezSZ3Gu4Fvcmb3oZRvioIEIrorte7fLVatdfR6C0KZtIWxHnF3?=
 =?iso-8859-1?Q?h2zQRXjblyiq3hO/nBEPgcfDZ/bCedQww3YiyE0gytk7xi1X7oqxkK5HTY?=
 =?iso-8859-1?Q?9aky+uN2roiUMgGHpxO2NvFoX5Y+UYMsXYY75rWPI2g47X1ilXZc2KKoIf?=
 =?iso-8859-1?Q?lNCwz8a0AROESV2JlnMrePiM7b0pcZ4IMd6h8nmhKQSApMxhEh9iz0eBLA?=
 =?iso-8859-1?Q?yGQ4w59w4M4E6BGQfpJ7tKTfMeJ9W3htyPRxiD7GDORZd3Zlsn07HDvCxb?=
 =?iso-8859-1?Q?iBX5Cz1adCV708Mebz+vO1Zq4NIiK9qc0iFvR4rCOxecUjswXRPr42HOLO?=
 =?iso-8859-1?Q?iZQEtMEOQSrtw99VcPKW6a6aszIoOyuJF/ZtODekHo/OEpmUcLn5BInpsD?=
 =?iso-8859-1?Q?jtJ2j0xu1yMrPlB3vhJIA3Smdbnw+iNKtCu12mbMUjnmcu6om1Mv6dDA2Q?=
 =?iso-8859-1?Q?ecCGVf8lFZ/yOajwYfedF5QyJObQC7EkCrANB8FMxxZsMzXTeD3mZJrJbM?=
 =?iso-8859-1?Q?1HtGJ1tYMXdpe1hlz1zl78xPKSU/o5CRi7zR2BsAHf7rEuuxXloErGwmGB?=
 =?iso-8859-1?Q?N/UUJjt3qeD/wnLJmSO8AOk3fQxsgzMR812XfTg297ywbfySvovv5AO2lP?=
 =?iso-8859-1?Q?baMTMWQi/A1U/DqJmxEHv6Z0JOWwdi2iR0YICvlubVNAdgBY6rnZSyWwpf?=
 =?iso-8859-1?Q?rA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(86362001)(186003)(33656002)(7116003)(38350700002)(38100700002)(508600001)(4270600006)(19618925003)(26005)(6200100001)(6666004)(7696005)(52116002)(9686003)(3480700007)(55016003)(40180700001)(40160700002)(8676002)(6862004)(7416002)(7406005)(7366002)(2906002)(558084003)(66476007)(66556008)(66946007)(8936002)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1IAZfxh+qq6LYEoViwVtkxm/WGAqg9c/3cJB897uRVreYfsY3urp4gIYh0?=
 =?iso-8859-1?Q?U02yFcYiOYeWzsCtg4PiNkoZ4jX/VITrOUcMQ5JiFKcZEnP4OiaYyvPYvQ?=
 =?iso-8859-1?Q?p2TwH+y8qOK1JXkqUOC6FPEJrXUDzCFw/kFHibxH7Nn9k3wX1FXo5JCIm3?=
 =?iso-8859-1?Q?NX1OoDJe1feMv0E1A25JCVwTqfk6wr6Tsru69XZGeZJ6jormhRdHmILu2K?=
 =?iso-8859-1?Q?kQNen8BYH+jFIdQJlnNvsiJ/8YRqt2u4TVMwSOXKkTR9VsP+3uAaTFvQhN?=
 =?iso-8859-1?Q?nA8dpEsMfZxASsmyjnxHA85mPdzvLtoMBj3AzB8hC+vkpZFz65+MZXTGe6?=
 =?iso-8859-1?Q?1CQ3wJkQhiQP6gYkfpTPSBndgdVkrZ07Ead395MnUnc4KtPGTes8iLynl1?=
 =?iso-8859-1?Q?UQBbPabfEKKD1bTeAFRv2J0q6BwyjkXbkwumpPHxEXOYesc0Rtc94XYPTB?=
 =?iso-8859-1?Q?zp6ybySKoOZmFAcmtt6C27nbmbQ5b+8pWVcveS5n2Pqpc8QfDkl6F0WB8M?=
 =?iso-8859-1?Q?wt+jJGhWhgIBYxl9jFMvhNpgC9sLNhTlO5ezIx78xa50wYirYEbx4vCD9R?=
 =?iso-8859-1?Q?uugabow7bdbfFWP9X7E+4atAfvcMcQSbi0Mii5Mv/zQGvYGxTSPSbYlHUo?=
 =?iso-8859-1?Q?0ejv8HWNpKGMMYKa0P6jfoezpIz7CONVF4UzT2BKJRy84UwqXk2OOSAQ1E?=
 =?iso-8859-1?Q?RfmyWI9BQ/RjE5fWfeAeEXgtCWL1WNxo5qXQOQ/tdjMPMeB0/+F0FyuDpk?=
 =?iso-8859-1?Q?hUuptgiFuJ+DNLPcAKK/AImFa+deMzaUK8Nu6FR/SVeQoXsjb3t1/oyTBF?=
 =?iso-8859-1?Q?i1Yhv8d6xDm+e3wTuFtgdp5iUFoXn91UaBlNRl/DnlvoVgXbyinYsqfaBU?=
 =?iso-8859-1?Q?21eo1VxYBwuVZw6nFjFL4wmXBVjCKK8+PUYZxIyZSoH57avi6t0NyvY9MT?=
 =?iso-8859-1?Q?Sqj9aVkO6i2TixuKlFtbCcWKRC+zA5/4Gnp45kGo+bHXJrDlpGIVQ8xTGI?=
 =?iso-8859-1?Q?JP33sF4+bCROS/uSdFIcJMbRZgJqDHqqQUiZ/iWJ/Y11eSpo7L64+5Huds?=
 =?iso-8859-1?Q?wHK5xgjIrpT5V3y71KlaENuQG/ZbHb71HrOQHc5iqICiRUXg4l40o5BcpW?=
 =?iso-8859-1?Q?K6NYm4a8toL5KRyDILwJZd4egBwHp3jPpzCKuXtY7P2TcjQokMe/rXHpiz?=
 =?iso-8859-1?Q?UileR/2HdQEC+zuZk5wYSIyRiJVeYBJgDvk/sxm2QSNnIbYdyXhvoiMjd0?=
 =?iso-8859-1?Q?mfI/k6aQclv+iuwONZC17rjwoyQneSm14M8d1j3QkVLBO668hMv+C1X4MG?=
 =?iso-8859-1?Q?ajZGBQxGNNRv388Q9nmQacGXUuVw2tJDDKsTsBpih3rjjDfHlMhozFhs03?=
 =?iso-8859-1?Q?c1Ys2/4Ue5EmsngZERopBpQC4nK7Wo9pI4MgOr/sWXPo6Of++SjXFuXtIF?=
 =?iso-8859-1?Q?sojFehXYIyBtgzZCvbXvOvCOx76u4JBr/ek1gUN99o8SD0/U+iBrub961s?=
 =?iso-8859-1?Q?97LLFVV793Kmyb0fsvmAmTaAmGXhKqbQt8ma+rcsOV9LMqt/aJuAcU3Zty?=
 =?iso-8859-1?Q?Z+HWQpWWfHze8/Otf6oZI0SBq/oXStZVo2cCTzPKdpjxkBMbzdDbZroeOF?=
 =?iso-8859-1?Q?RFKUK854GSL6NxB97Bb0aNQkInTZU/GrGu98ycyGHn9udTbuRlwc4MylG8?=
 =?iso-8859-1?Q?ytwGmak+8zIyl6jZfCdQAFdOlK7yAElGahGKr5LA8Ojfpex/6g5mp7sJ5N?=
 =?iso-8859-1?Q?e6Tw=3D=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed228b4b-55f4-4343-e05c-08da391419c1
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:19:32.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NO1Czb3StnwszVgKbGJmbrZD54srSJjWHi0YnQjUYjZTKx/vaNqO3l5R7FUGh9gz8Uy2y4PodYoZoWqgsQeP0ysmhvfWObFt9Aolkyq1WgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0608
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DATE_IN_PAST_24_48,
        DKIM_INVALID,DKIM_SIGNED,FORGED_SPF_HELO,KHOP_HELO_FCRDNS,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,RCVD_IN_PSBL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
        *      [42.159.164.98 listed in psbl.surriel.com]
        *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?42.159.164.98>]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4705]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [42.159.164.98 listed in wl.mailspike.net]
        *  0.0 SPF_NONE SPF: sender does not publish an SPF Record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  1.3 DATE_IN_PAST_24_48 Date: is 24 to 48 hours before Received:
        *      date
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FORGED_SPF_HELO No description available.
        *  0.0 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Can you do a job with me?
