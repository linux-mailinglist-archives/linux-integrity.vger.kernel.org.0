Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6C9294C85
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Oct 2020 14:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411881AbgJUM0F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Oct 2020 08:26:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbgJUM0E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Oct 2020 08:26:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09LC3ZMk115791;
        Wed, 21 Oct 2020 08:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=bvSsPq3wOmmtOX1az4xCyTfWApYvcQkBAvmNyM4Gu/k=;
 b=jDOgf0Qi/Sfe+6zHOdryNDHp6PEAoQIUv6TAVYN7AN285iFKam5UdOLQ1rLc2u59HXdO
 qg8wMwH6KEvRao0u/p/Gn5/JnkCxOqU8bYpsMJib1LZPjfxzMgCH8UdqmvZI6mrDFZBJ
 psJuJMBJVwMkuDPePGZnuPboeSizU2G648FNjJV/aUsVynXGY/J8gsWJB9rRtcnkOudB
 NhUXSzPevHWifnim3vTckQy27ecypWvuQoaL11zQ2F7SyapPGwvu/L47c5PM2csZx65T
 NtHUILzQEqxFqIa+MrnDnoOedaMn021bLHv2yhV4lH9haaHUK4iS0rdULyz4gv5i2PxX dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ak37krm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 08:25:41 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09LC5592123886;
        Wed, 21 Oct 2020 08:25:41 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ak37krkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 08:25:41 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09LCCH5h010636;
        Wed, 21 Oct 2020 12:25:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 347qvhca8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 12:25:38 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09LCPa9t28901750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Oct 2020 12:25:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 883C04C050;
        Wed, 21 Oct 2020 12:25:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 709A94C040;
        Wed, 21 Oct 2020 12:25:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.92.86])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Oct 2020 12:25:32 +0000 (GMT)
Message-ID: <7b2ccd620a9de5c2fd57b8e8aeb41d5476f83b28.camel@linux.ibm.com>
Subject: Re: [PATCH v7 1/4] KEYS: trusted: Add generic trusted keys framework
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Date:   Wed, 21 Oct 2020 08:25:31 -0400
In-Reply-To: <CAFA6WYM7aJwP9j_ayGvbJPu-cyv87rsm9N4Wj2OCOMnmfDx+Rw@mail.gmail.com>
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
         <1602065268-26017-2-git-send-email-sumit.garg@linaro.org>
         <8e07f9401c9f7e18fb1453b7b290472c0049c6e6.camel@linux.ibm.com>
         <CAFA6WYM7aJwP9j_ayGvbJPu-cyv87rsm9N4Wj2OCOMnmfDx+Rw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-21_05:2020-10-20,2020-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=2 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-10-21 at 11:16 +0530, Sumit Garg wrote:
> Thanks Mimi for your comments.
> 
> On Wed, 21 Oct 2020 at 08:51, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Wed, 2020-10-07 at 15:37 +0530, Sumit Garg wrote:
> >
> > > +/*
> > > + * trusted_destroy - clear and free the key's payload
> > > + */
> > > +static void trusted_destroy(struct key *key)
> > > +{
> > > +     kfree_sensitive(key->payload.data[0]);
> > > +}
> > > +
> > > +struct key_type key_type_trusted = {
> > > +     .name = "trusted",
> > > +     .instantiate = trusted_instantiate,
> > > +     .update = trusted_update,
> > > +     .destroy = trusted_destroy,
> > > +     .describe = user_describe,
> > > +     .read = trusted_read,
> > > +};
> > > +EXPORT_SYMBOL_GPL(key_type_trusted);
> > > +
> > > +static int __init init_trusted(void)
> > > +{
> > > +     int i, ret = 0;
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> > > +             if (trusted_key_source &&
> > > +                 strncmp(trusted_key_source, trusted_key_sources[i].name,
> > > +                         strlen(trusted_key_sources[i].name)))
> > > +                     continue;
> > > +
> > > +             trusted_key_ops = trusted_key_sources[i].ops;
> > > +
> > > +             ret = trusted_key_ops->init();
> > > +             if (!ret)
> > > +                     break;
> > > +     }
> >
> > In the case when the module paramater isn't specified and both TPM and
> > TEE are enabled, trusted_key_ops is set to the last source initialized.
> 
> I guess there is some misunderstanding. Here it's only a single trust
> source (TPM *or* TEE) is initialized and only that trust source would
> be active at runtime. And trusted_key_ops would be initialized to the
> first trust source whose initialization is successful (see check: "if
> (!ret)").

My mistake.

> 
> > After patch 2/4, the last trusted source initialized is TEE.  If the
> > intention is to limit it to either TPM or TEE, then trusted_key_ops
> > should have a default value, which could be overwritten at runtime.
> > That would address Luke Hind's concerns of making the decision at
> > compile time.
> 
> I think traversing the trust source list with the initial value being
> TPM would be default value.

Agreed
> 
> >
> > trusted_key_ops should be defined as __ro_after_init, like is currently
> > done for other LSM structures.
> 
> Sure, will do.

Thanks
> 
> >
> > > +
> > > +     /*
> > > +      * encrypted_keys.ko depends on successful load of this module even if
> > > +      * trusted key implementation is not found.
> > > +      */
> > > +     if (ret == -ENODEV)
> > > +             return 0;
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static void __exit cleanup_trusted(void)
> > > +{
> > > +     trusted_key_ops->exit();
> >
> > If the intention is really to support both TPM and TEE trusted keys at
> > the same time, as James suggested, then the same "for" loop as in
> > init_trusted() is needed here and probably elsewhere.
> 
> Current intention is to only support a single trust source (TPM or
> TEE) at runtime. But in future if there are use-cases then framework
> can be extended to support multiple trust sources at runtime as well.

Ok, the last sentence of the patch description, "Also, add a module
parameter in order to select a particular trust source in case a
platform support multiple trust sources.", needs to be expanded to:
- indicate only one trust source at a time is supported
- indicate the default, if the module_param is not specified

I would also change the word from "add" to "define".   The new "source"
module parameter needs to be added to the admin-guide/kernel-parameters 
documentation.

thanks,

Mimi   


