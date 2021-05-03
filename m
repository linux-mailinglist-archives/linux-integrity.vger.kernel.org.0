Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82E637170A
	for <lists+linux-integrity@lfdr.de>; Mon,  3 May 2021 16:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhECOtq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 10:49:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2987 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhECOtp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 10:49:45 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FYm145kwmz6wljg;
        Mon,  3 May 2021 22:43:04 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 3 May 2021 16:48:50 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Mon, 3 May 2021 16:48:50 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: RE: [PATCH v5 09/12] evm: Allow setxattr() and setattr() for
 unmodified metadata
Thread-Topic: [PATCH v5 09/12] evm: Allow setxattr() and setattr() for
 unmodified metadata
Thread-Index: AQHXK5xeSg6sM/30eEKbqlkQ5rVFkKrRv8yAgAAwwJA=
Date:   Mon, 3 May 2021 14:48:50 +0000
Message-ID: <06edfc9f779447b9b93f26628327d1e5@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-10-roberto.sassu@huawei.com>
 <8493d7e2b0fefa4cd3861bd6b7ee6f2340aa7434.camel@linux.ibm.com>
In-Reply-To: <8493d7e2b0fefa4cd3861bd6b7ee6f2340aa7434.camel@linux.ibm.com>
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
> Sent: Monday, May 3, 2021 3:00 PM
> On Wed, 2021-04-07 at 12:52 +0200, Roberto Sassu wrote:
> 
> > diff --git a/security/integrity/evm/evm_main.c
> b/security/integrity/evm/evm_main.c
> > @@ -389,6 +473,11 @@ static int evm_protect_xattr(struct
> user_namespace *mnt_userns,
> >  	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
> >  		return 0;
> >
> > +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> > +	    !evm_xattr_change(mnt_userns, dentry, xattr_name, xattr_value,
> > +			      xattr_value_len))
> > +		return 0;
> > +
> 
> If the purpose of evm_protect_xattr() is to prevent allowing an invalid
> security.evm xattr from being re-calculated and updated, making it
> valid, INTEGRITY_PASS_IMMUTABLE shouldn't need to be conditional.  Any
> time there is an attr or xattr change, including setting it to the
> existing value, the status flag should be reset.

The status is always reset if evm_protect_xattr() returns 0. This does not
change.

Not making INTEGRITY_PASS_IMMUTABLE conditional would cause issues.
Suppose that the status is INTEGRITY_FAIL. Writing the same xattr would
cause evm_protect_xattr() to return 0 and the HMAC to be updated.

> I'm wondering if making INTEGRITY_PASS_IMMUTABLE conditional would
> prevent the file from being resigned.

INTEGRITY_FAIL_IMMUTABLE should be enough to continue the
operation.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> >  	if (evm_status != INTEGRITY_PASS)
> >  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> d_backing_inode(dentry),
> >  				    dentry->d_name.name,
> "appraise_metadata",
> 
> This would then be updated to if not INTEGRITY_PASS or
> INTEGRITY_PASS_IMMUTABLE.  The subsequent "return" would need to be
> updated as well.
> 
> thanks,
> 
> Mimi

