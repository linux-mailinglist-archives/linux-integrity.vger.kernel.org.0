Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE1126E193
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgIQRB6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 13:01:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728817AbgIQRB4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 13:01:56 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HFWOrI195002;
        Thu, 17 Sep 2020 11:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=RlLu7fEzQhErA1mRCwGKGmNdVADPy1rMotSoaBtBdIg=;
 b=Hytq5zNcwaqjrHNcFhh5Td0LiQaEVe7PVTvvMRcIygGNT1Qa/FmtoVPCKjc7koH81vV6
 ytzPPiGGqV45LHDn9D+GLHx3xvck0F59cQbUhIvxCVegRAOtvUNACmDZaVQc2+tP2pd+
 UHw18R+TWFLbgu++PLcHg94AGlmG7MEyjPislsHNdVsmZnVu1ErKID7kH3MDdvfRs188
 T7EchYazjccmpo9nAAP/U3VBAWPhL/JTTZE/Vb9d8ZsqR0/K3ZOLVYyfpAeRM486wMIo
 np3liptkYverIlV0zmXW1gYqmHuw87wt9mNb1Zj0zBZ55REfDkmJc9m+AYVnk7UVdtGJ ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m9wuj2b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 11:55:38 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08HFYIN8005616;
        Thu, 17 Sep 2020 11:55:37 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m9wuj29w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 11:55:37 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08HFrnvO005229;
        Thu, 17 Sep 2020 15:55:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 33k65v15px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 15:55:35 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08HFrw7933423620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 15:53:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3B70A4054;
        Thu, 17 Sep 2020 15:55:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE937A4067;
        Thu, 17 Sep 2020 15:55:31 +0000 (GMT)
Received: from sig-9-65-208-105.ibm.com (unknown [9.65.208.105])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Sep 2020 15:55:31 +0000 (GMT)
Message-ID: <c2aca1d65e8febdd83237d0babd840bb2b6c282d.camel@linux.ibm.com>
Subject: Re: [PATCH v2 11/12] ima: Introduce template field evmsig and write
 to field sig as fallback
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Thu, 17 Sep 2020 11:55:30 -0400
In-Reply-To: <860d8441788b4ff799db738e535e2d7e@huawei.com>
References: <20200904092339.19598-1-roberto.sassu@huawei.com>
         <20200904092643.20013-7-roberto.sassu@huawei.com>
         <c8d3c70e74e607a4b73239bef1e9db0d304200fc.camel@linux.ibm.com>
         <860d8441788b4ff799db738e535e2d7e@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_10:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=3 bulkscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170117
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-09-17 at 15:05 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Thursday, September 17, 2020 4:25 PM
> > Hi Roberto,
> > 
> > On Fri, 2020-09-04 at 11:26 +0200, Roberto Sassu wrote:
> > > With the patch to accept EVM portable signatures when the
> > > appraise_type=imasig requirement is specified in the policy, appraisal can
> > > be successfully done even if the file does not have an IMA signature.
> > >
> > > However, remote attestation would not see that a different signature
> > type
> > > was used, as only IMA signatures can be included in the measurement list.
> > > This patch solves the issue by introducing the new template field 'evmsig'
> > > to show EVM portable signatures and by including its value in the existing
> > > field 'sig' if the IMA signature is not found.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > 
> > Thank you!   Just a minor comment below.
> > 
> > <snip>
> > 
> > > diff --git a/security/integrity/ima/ima_template_lib.c
> > b/security/integrity/ima/ima_template_lib.c
> > > index c022ee9e2a4e..2c596c2a89cc 100644
> > > --- a/security/integrity/ima/ima_template_lib.c
> > > +++ b/security/integrity/ima/ima_template_lib.c
> > >
> > > @@ -438,7 +439,7 @@ int ima_eventsig_init(struct ima_event_data
> > *event_data,
> > >  	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
> > >
> > >  	if ((!xattr_value) || (xattr_value->type !=
> > EVM_IMA_XATTR_DIGSIG))
> > > -		return 0;
> > > +		return ima_eventevmsig_init(event_data, field_data);
> > >
> > >  	return ima_write_template_field_data(xattr_value, event_data-
> > >xattr_len,
> > >  					     DATA_FMT_HEX, field_data);
> > > @@ -484,3 +485,39 @@ int ima_eventmodsig_init(struct ima_event_data
> > *event_data,
> > >  	return ima_write_template_field_data(data, data_len,
> > DATA_FMT_HEX,
> > >  					     field_data);
> > >  }
> > > +
> > > +/*
> > > + *  ima_eventevmsig_init - include the EVM portable signature as part of
> > the
> > > + *  template data
> > > + */
> > > +int ima_eventevmsig_init(struct ima_event_data *event_data,
> > > +			 struct ima_field_data *field_data)
> > > +{
> > > +	struct evm_ima_xattr_data *xattr_data = NULL;
> > > +	int rc = 0;
> > > +
> > > +	if (!event_data->file)
> > > +		return 0;
> > > +
> > > +	if (!(file_inode(event_data->file)->i_opflags & IOP_XATTR))
> > > +		return 0;
> > > +
> > > +	rc = vfs_getxattr_alloc(file_dentry(event_data->file),
> > XATTR_NAME_EVM,
> > > +				(char **)&xattr_data, 0, GFP_NOFS);
> > > +	if (rc <= 0) {
> > > +		if (!rc || rc == -ENODATA)
> > > +			return 0;
> > > +
> > > +		return rc;
> > 
> > We're including the EVM signature on a best effort basis to help with
> > attestation.  Do we really care why it failed?   Are we going to act on
> > it?
> 
> Hi Mimi
> 
> other template field functions have a similar behavior. They return
> an error if an operation necessary to retrieve the data cannot be
> performed. Should I always return 0?

The EVM signature case is more similar to the IMA signature case, than
to other fields.  In the signature cases, if the signature exists, it
is included.   My suggestion is based on the difference in how the
vfs_getxattr_alloc() results are handled.

thanks,

Mimi

