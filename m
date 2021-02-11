Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831EA319689
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 00:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhBKXZ5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 18:25:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14750 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229787AbhBKXZ4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 18:25:56 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BND12T019060;
        Thu, 11 Feb 2021 18:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Q3tZs7Ggda0KW9A1uSBOPNOkPbrNTd7b1dOpH8wmYSM=;
 b=G6UvrJhxqLulUI+OROj5jeuE1ditML5HmF37CO8sWm8zbo794yHg9zIvNDJPtRmVo5rU
 7cyQSHy6fw3TXjVSNG274NPZKFhojq29IA2ARerDE6RX1GnHbk10zVMtGvUZFzvvwDTG
 3hpJMb9zDyKTpl52UDS6bSJUWp0g13FSXd8xWZFjVehrrAmYx/3dr2Sf1PdimzKavkTc
 N1NXZdGqotIpgwbFYMaRFra9dZvzqzKuqCwNy7oYdWpIKedliLeOZc7EvuyWJ/bcoslF
 RbQ6ij5tcUS3VHMKdj9rcE5rPblCaRmdmtqcyIqG/FE87roRpxgY01AZXOCyzafpMcC/ ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ne2a86y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 18:25:13 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11BNPDbk067480;
        Thu, 11 Feb 2021 18:25:13 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ne2a86xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 18:25:13 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BNDLI4028249;
        Thu, 11 Feb 2021 23:25:11 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 36hskb33pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 23:25:11 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BNP8W926345748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 23:25:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48CA54203F;
        Thu, 11 Feb 2021 23:25:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B9E642045;
        Thu, 11 Feb 2021 23:25:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.11.205])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 23:25:06 +0000 (GMT)
Message-ID: <31d434e0861a02b214e3189f958921384aa75362.camel@linux.ibm.com>
Subject: Re: [PATCH 4/5] keys: define build time generated ephemeral kernel
 CA key
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Feb 2021 18:25:05 -0500
In-Reply-To: <90213e4d-4c47-aec3-46f2-4b8e4ce0838f@linux.ibm.com>
References: <20210211195435.135582-1-nayna@linux.ibm.com>
         <20210211195435.135582-5-nayna@linux.ibm.com>
         <90213e4d-4c47-aec3-46f2-4b8e4ce0838f@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110175
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-02-11 at 17:13 -0500, Stefan Berger wrote:
> On 2/11/21 2:54 PM, Nayna Jain wrote:
> > Certificates being loaded onto the IMA trusted keyring must be signed by
> > a key on either the builtin and secondary trusted keyring.
> >
> > This patch creates and includes in the kernel image an ephemeral CA
> > key, at build time when IMA_APPRAISE_MODSIG is enabled.
> >
> > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> > ---

<snip>

> > diff --git a/certs/Makefile b/certs/Makefile
> 
> > @@ -60,14 +78,23 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
> >   	@$(kecho) "### needs to be run as root, and uses a hardware random"
> >   	@$(kecho) "### number generator if one is available."
> >   	@$(kecho) "###"
> > +ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
> > +	# Generate kernel build time CA Certificate.
> > +	@$(Q)openssl req -new -nodes -utf8 \
> > +		-$(CONFIG_MODULE_SIG_HASH) -days 36500 \
> > +		-subj "/CN=Build time autogenerated kernel CA key" \
> > +		-batch -x509 -config $(obj)/x509.genkey \
> > +		-outform PEM -out $(CA_KEY) \
> > +		-keyout $(CA_KEY) -extensions ca_ext \
> > +		$($(quiet)redirect_openssl)
> > +endif # CONFIG_IMA_APPRAISE_MODSIG
> >   	$(Q)openssl req -new -nodes -utf8 \
> >   		-batch -config $(obj)/x509.genkey \
> >   		-outform PEM -out $(obj)/signing_key.csr \
> >   		-keyout $(obj)/signing_key.key -extensions myexts \
> >   		$($(quiet)redirect_openssl)
> >   	$(Q)openssl x509 -req -days 36500 -in $(obj)/signing_key.csr \
> > -		-outform PEM -out $(obj)/signing_key.crt \
> > -		-signkey $(obj)/signing_key.key \
> > +		-outform PEM -out $(obj)/signing_key.crt $(SIGNER) \
> >   		-$(CONFIG_MODULE_SIG_HASH) -extensions myexts \
> >   		-extfile $(obj)/x509.genkey \
> >   		$($(quiet)redirect_openssl)
> 
> It may make things easier (also below) if the CA was always created and 
> the kernel signing key was always signed by that CA rather than doing 
> this only in the IMA_APPRAISE_MODSIG case. Maybe someone else has an 
> opinion on that?

Thanks, Stefan.  It would definitely simplify the code.  We wanted to
minimize the code change and solicit feedback, before making such a
change.

Mimi

