Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D026DF86
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 17:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgIQPW1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 11:22:27 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2881 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728123AbgIQPVV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 11:21:21 -0400
X-Greylist: delayed 955 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 11:21:19 EDT
Received: from lhreml716-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id AEE29DF0C20A8C2FBF6C;
        Thu, 17 Sep 2020 16:05:16 +0100 (IST)
Received: from fraeml705-chm.china.huawei.com (10.206.15.54) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 17 Sep 2020 16:05:16 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 17 Sep 2020 17:05:15 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Thu, 17 Sep 2020 17:05:15 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH v2 11/12] ima: Introduce template field evmsig and write
 to field sig as fallback
Thread-Topic: [PATCH v2 11/12] ima: Introduce template field evmsig and write
 to field sig as fallback
Thread-Index: AQHWgp4r9oDj/B/2AE+GMiikS2WcY6ls1ewAgAAqoSA=
Date:   Thu, 17 Sep 2020 15:05:15 +0000
Message-ID: <860d8441788b4ff799db738e535e2d7e@huawei.com>
References: <20200904092339.19598-1-roberto.sassu@huawei.com>
         <20200904092643.20013-7-roberto.sassu@huawei.com>
 <c8d3c70e74e607a4b73239bef1e9db0d304200fc.camel@linux.ibm.com>
In-Reply-To: <c8d3c70e74e607a4b73239bef1e9db0d304200fc.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> Sent: Thursday, September 17, 2020 4:25 PM
> Hi Roberto,
> 
> On Fri, 2020-09-04 at 11:26 +0200, Roberto Sassu wrote:
> > With the patch to accept EVM portable signatures when the
> > appraise_type=imasig requirement is specified in the policy, appraisal can
> > be successfully done even if the file does not have an IMA signature.
> >
> > However, remote attestation would not see that a different signature
> type
> > was used, as only IMA signatures can be included in the measurement list.
> > This patch solves the issue by introducing the new template field 'evmsig'
> > to show EVM portable signatures and by including its value in the existing
> > field 'sig' if the IMA signature is not found.
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> Thank you!   Just a minor comment below.
> 
> <snip>
> 
> > diff --git a/security/integrity/ima/ima_template_lib.c
> b/security/integrity/ima/ima_template_lib.c
> > index c022ee9e2a4e..2c596c2a89cc 100644
> > --- a/security/integrity/ima/ima_template_lib.c
> > +++ b/security/integrity/ima/ima_template_lib.c
> >
> > @@ -438,7 +439,7 @@ int ima_eventsig_init(struct ima_event_data
> *event_data,
> >  	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
> >
> >  	if ((!xattr_value) || (xattr_value->type !=
> EVM_IMA_XATTR_DIGSIG))
> > -		return 0;
> > +		return ima_eventevmsig_init(event_data, field_data);
> >
> >  	return ima_write_template_field_data(xattr_value, event_data-
> >xattr_len,
> >  					     DATA_FMT_HEX, field_data);
> > @@ -484,3 +485,39 @@ int ima_eventmodsig_init(struct ima_event_data
> *event_data,
> >  	return ima_write_template_field_data(data, data_len,
> DATA_FMT_HEX,
> >  					     field_data);
> >  }
> > +
> > +/*
> > + *  ima_eventevmsig_init - include the EVM portable signature as part of
> the
> > + *  template data
> > + */
> > +int ima_eventevmsig_init(struct ima_event_data *event_data,
> > +			 struct ima_field_data *field_data)
> > +{
> > +	struct evm_ima_xattr_data *xattr_data = NULL;
> > +	int rc = 0;
> > +
> > +	if (!event_data->file)
> > +		return 0;
> > +
> > +	if (!(file_inode(event_data->file)->i_opflags & IOP_XATTR))
> > +		return 0;
> > +
> > +	rc = vfs_getxattr_alloc(file_dentry(event_data->file),
> XATTR_NAME_EVM,
> > +				(char **)&xattr_data, 0, GFP_NOFS);
> > +	if (rc <= 0) {
> > +		if (!rc || rc == -ENODATA)
> > +			return 0;
> > +
> > +		return rc;
> 
> We're including the EVM signature on a best effort basis to help with
> attestation.  Do we really care why it failed?   Are we going to act on
> it?

Hi Mimi

other template field functions have a similar behavior. They return
an error if an operation necessary to retrieve the data cannot be
performed. Should I always return 0?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> Mimi
> 
> > +	}
> > +
> > +	if (xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG) {
> > +		kfree(xattr_data);
> > +		return 0;
> > +	}
> > +
> > +	rc = ima_write_template_field_data((char *)xattr_data, rc,
> DATA_FMT_HEX,
> > +					   field_data);
> > +	kfree(xattr_data);
> > +	return rc;
> > +}
> 

