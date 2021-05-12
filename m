Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B7137BB5A
	for <lists+linux-integrity@lfdr.de>; Wed, 12 May 2021 12:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhELK4m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 May 2021 06:56:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3065 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhELK4l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 May 2021 06:56:41 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FgBLl6p5Tz6ppQ3;
        Wed, 12 May 2021 18:47:11 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 12 May 2021 12:55:29 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Wed, 12 May 2021 12:55:29 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 10/11] ima: Introduce template field evmsig and write
 to field sig as fallback
Thread-Topic: [PATCH v6 10/11] ima: Introduce template field evmsig and write
 to field sig as fallback
Thread-Index: AQHXQaK0P4hV9Rbe4USY0rnHgJAPHarewKKAgAD2aHA=
Date:   Wed, 12 May 2021 10:55:29 +0000
Message-ID: <cca5e15939cc46b39d436cb7578c26e3@huawei.com>
References: <20210505112935.1410679-1-roberto.sassu@huawei.com>
         <20210505113329.1410943-6-roberto.sassu@huawei.com>
 <f1e16fe91bd80437ea2cf9ed60c40a3687fa0e40.camel@linux.ibm.com>
In-Reply-To: <f1e16fe91bd80437ea2cf9ed60c40a3687fa0e40.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> Sent: Wednesday, May 12, 2021 12:12 AM
> Hi Roberto,
> 
> On Wed, 2021-05-05 at 13:33 +0200, Roberto Sassu wrote:
> > With the patch to accept EVM portable signatures when the
> > appraise_type=imasig requirement is specified in the policy, appraisal can
> > be successfully done even if the file does not have an IMA signature.
> >
> > However, remote attestation would not see that a different signature type
> > was used, as only IMA signatures can be included in the measurement list.
> > This patch solves the issue by introducing the new template field 'evmsig'
> > to show EVM portable signatures and by including its value in the existing
> > field 'sig' if the IMA signature is not found.
> 
> With this patch, instead of storing the file data signature, the file
> metadata signature is stored in the IMA measurement list, as designed.
> There's a minor problem.  Unlike the file data signature, the
> measurement list record does not contain all the information needed to
> verify the file metadata signature.

Ok, we could add new template fields later.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> Mimi

