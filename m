Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0072D2575D9
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Aug 2020 10:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHaIvx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Aug 2020 04:51:53 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgHaIvx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Aug 2020 04:51:53 -0400
Received: from lhreml731-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 90684E58730BB099C92E;
        Mon, 31 Aug 2020 09:51:51 +0100 (IST)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 lhreml731-chm.china.huawei.com (10.201.108.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Mon, 31 Aug 2020 09:51:51 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 31 Aug 2020 10:51:50 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Mon, 31 Aug 2020 10:51:50 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH 06/11] evm: Allow setxattr() and setattr() if metadata
 digest won't change
Thread-Topic: [PATCH 06/11] evm: Allow setxattr() and setattr() if metadata
 digest won't change
Thread-Index: AQHWRYqUlnQLtNKv1EOX9vSSVMUNoKlHdHOAgArmSEA=
Date:   Mon, 31 Aug 2020 08:51:50 +0000
Message-ID: <920bb5b700bf41f08ae74de8b14aaf41@huawei.com>
References: <20200618160329.1263-2-roberto.sassu@huawei.com>
         <20200618160458.1579-6-roberto.sassu@huawei.com>
 <802588e6892951076babbc48aa0320032e4b1926.camel@linux.ibm.com>
In-Reply-To: <802588e6892951076babbc48aa0320032e4b1926.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.205.186]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> Sent: Monday, August 24, 2020 2:17 PM
> On Thu, 2020-06-18 at 18:04 +0200, Roberto Sassu wrote:
> > If metadata are immutable, they cannot be changed. If metadata are
> already
> > set to the final value before cp and tar restore the value from the source,
> > those applications display an error even if the operation is legitimate
> > (they don't change the value).
> 
> "metadata" is singular.   The first sentence would be clearer by using
> the specific metadata.  What problem are you trying to solve?  It
> doesn't look like you're trying to solve the problem of writing the EVM
> portable signatures without an exiting HMAC.
> 
> >
> > This patch determines whether setxattr()/setattr() change metadata and,
> if
> > not, allows the operations even if metadata are immutable.
> 
> Doesn't setxattr/setattr always change file metadata?  Please describe
> the real problem.

Yes. The problem is that tar/cp change metadata even if its value is
already correct after the file has been created. These operations
will be denied because metadata is immutable and verification
succeeds.

> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/evm/evm_main.c | 72
> +++++++++++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> >
> > diff --git a/security/integrity/evm/evm_main.c
> b/security/integrity/evm/evm_main.c
> > index 30072030f05d..41cc6a4aaaab 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/integrity.h>
> >  #include <linux/evm.h>
> >  #include <linux/magic.h>
> > +#include <linux/posix_acl_xattr.h>
> >
> >  #include <crypto/hash.h>
> >  #include <crypto/hash_info.h>
> > @@ -305,6 +306,56 @@ static enum integrity_status
> evm_verify_current_integrity(struct dentry *dentry)
> >  	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
> >  }
> >
> > +static int evm_xattr_acl_change(struct dentry *dentry, const char
> *xattr_name,
> > +				const void *xattr_value, size_t
> xattr_value_len)
> > +{
> > +	umode_t mode;
> > +	struct posix_acl *acl = NULL, *acl_res;
> > +	struct inode *inode = d_backing_inode(dentry);
> > +	int rc;
> > +
> > +	/* UID/GID in ACL have been already converted from user to init ns
> */
> > +	acl = posix_acl_from_xattr(&init_user_ns, xattr_value,
> xattr_value_len);
> > +	if (!acl)
> > +		return 1;
> > +
> > +	acl_res = acl;
> > +	rc = posix_acl_update_mode(inode, &mode, &acl_res);
> > +
> > +	posix_acl_release(acl);
> > +
> > +	if (rc)
> > +		return 1;
> > +
> > +	if (acl_res && inode->i_mode != mode)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static int evm_xattr_change(struct dentry *dentry, const char
> *xattr_name,
> > +			    const void *xattr_value, size_t xattr_value_len)
> > +{
> > +	char *xattr_data = NULL;
> > +	int rc = 0;
> > +
> > +	if (posix_xattr_acl(xattr_name))
> > +		return evm_xattr_acl_change(dentry, xattr_name,
> xattr_value,
> > +					    xattr_value_len);
> > +
> > +	rc = vfs_getxattr_alloc(dentry, xattr_name, &xattr_data, 0,
> GFP_NOFS);
> > +	if (rc < 0)
> > +		return 1;
> > +
> > +	if (rc == xattr_value_len)
> > +		rc = memcmp(xattr_value, xattr_data, rc);
> > +	else
> > +		rc = 1;
> > +
> > +	kfree(xattr_data);
> > +	return rc;
> > +}
> > +
> >  /*
> >   * evm_protect_xattr - protect the EVM extended attribute
> >   *
> > @@ -361,6 +412,10 @@ static int evm_protect_xattr(struct dentry
> *dentry, const char *xattr_name,
> >  	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
> >  		return 0;
> >
> > +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> > +	    !evm_xattr_change(dentry, xattr_name, xattr_value,
> xattr_value_len))
> > +		return 0;
> > +
> >  	if (evm_status != INTEGRITY_PASS)
> >  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> d_backing_inode(dentry),
> >  				    dentry->d_name.name,
> "appraise_metadata",
> > @@ -477,6 +532,19 @@ void evm_inode_post_removexattr(struct dentry
> *dentry, const char *xattr_name)
> >  	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
> >  }
> >
> > +static int evm_attr_change(struct dentry *dentry, struct iattr *attr)
> 
> static functions don't normally require a function comment, but in this
> case it wouldn't hurt to clarify why the uid, gid, mode bits are set,
> but aren't being modified.
> Similarly a function comment would help with the readability of
> evm_xattr_acl_change().

Ok.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> Mimi
> 
> > +{
> > +	struct inode *inode = d_backing_inode(dentry);
> > +	unsigned int ia_valid = attr->ia_valid;
> > +
> > +	if ((!(ia_valid & ATTR_UID) || uid_eq(attr->ia_uid, inode->i_uid))
> &&
> > +	    (!(ia_valid & ATTR_GID) || gid_eq(attr->ia_gid, inode->i_gid)) &&
> > +	    (!(ia_valid & ATTR_MODE) || attr->ia_mode == inode->i_mode))
> > +		return 0;
> > +
> > +	return 1;
> > +}
> > +
> >  /**
> >   * evm_inode_setattr - prevent updating an invalid EVM extended
> attribute
> >   * @dentry: pointer to the affected dentry
> > @@ -506,6 +574,10 @@ int evm_inode_setattr(struct dentry *dentry,
> struct iattr *attr)
> >  	    (evm_status == INTEGRITY_FAIL_IMMUTABLE))
> >  		return 0;
> >
> > +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> > +	    !evm_attr_change(dentry, attr))
> > +		return 0;
> > +
> >  	integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> d_backing_inode(dentry),
> >  			    dentry->d_name.name, "appraise_metadata",
> >  			    integrity_status_msg[evm_status], -EPERM, 0);
> 

