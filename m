Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71695198191
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 18:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgC3Qpt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 12:45:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729372AbgC3Qps (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 12:45:48 -0400
Received: from lhreml730-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A42FDB5919EEB1BC07AA;
        Mon, 30 Mar 2020 17:45:46 +0100 (IST)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 lhreml730-chm.china.huawei.com (10.201.108.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1713.5; Mon, 30 Mar 2020 17:45:46 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 30 Mar 2020 18:45:45 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Mon, 30 Mar 2020 18:45:45 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Lev Olshvang <levonshe@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@us.ibm.com>
CC:     Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH] integrity ima_policy : Select files by suffix
Thread-Topic: [PATCH] integrity ima_policy : Select files by suffix
Thread-Index: AQHWBo65vCeWAgZAckG7CKI3oVYVLahhUH0w
Date:   Mon, 30 Mar 2020 16:45:45 +0000
Message-ID: <1244b6bcc384413581da33c9b92743b8@huawei.com>
References: <20200330122434.GB28214@kl>
In-Reply-To: <20200330122434.GB28214@kl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.5.91]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> -----Original Message-----
> From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> owner@vger.kernel.org] On Behalf Of Lev Olshvang
> Sent: Monday, March 30, 2020 2:28 PM
> To: linux-integrity@vger.kernel.org; Mimi Zohar <zohar@us.ibm.com>
> Subject: [PATCH] integrity ima_policy : Select files by suffix
> 
> From: Lev Olshvang <levonshe@gmail.com>
> Date: Fri, 27 Mar 2020 20:50:01 +0300
> Reply-To:
> Subject: [PATCH] integrity ima_policy : Select files by suffix
> 
> IMA policy rule allows to select files based on uid, gid, fsuid. etc.
> One tremendously useful selector(IMHO) is the file suffix.
> 
> I think of systemd service files, configurution files, etc.
> 
> But the real goal of the patch is the ability to validate shell scripts.
> Shell provides too many different ways to run the script:
> input redirrection, pipe, command line parameters.

Given that file name is not protected, I would suggest to look instead at
the execution permission of the file. This information is protected by EVM.

In a second time, we could consider to enforce the policy in the interpreters
that every script must be executable, as suggested here:

https://lkml.org/lkml/2019/4/15/825

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
