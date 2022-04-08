Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902424F9D45
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Apr 2022 20:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiDHSwc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Apr 2022 14:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbiDHSwU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Apr 2022 14:52:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A39B1F0CB3;
        Fri,  8 Apr 2022 11:50:05 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238FWMdq004900;
        Fri, 8 Apr 2022 18:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0hV3lJeiKwojUvqkS79nwm4G4GE8s9EQ2hw4HTNHU08=;
 b=MhaSzuSj4S+4I24Yeph46gQUGWamxEhjRPOAAAEvm81jaRB72RJKTvNaJ83Eqbjqw+Yf
 I2lg+eNtZhAe+FzCvYCo9e4OAva1OQnSFsK4roEHM9QsLWhcyHFSc48xnoSJg28e9EPJ
 CgmGG+qQO9SQGwO2mT8Dt6/+1FEQCHpsMzyL5eEPuB51PlP6koIY49jmNb7f5/efkJk2
 /ZYvJ+O2J8jomU2YYECmlQ1m/7cwqjK4v2UAYEXOf8prwkZ9TzqlWcFgl/YD3VIy4Os0
 7CGq9dpTWCTgHiw3yICRkgmgpdwrbGxF5MLy8drbnxaPGR/RziNDixLBSbrb5z9UT/pw Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fad2h0ky4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 18:49:42 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 238IXjJU019573;
        Fri, 8 Apr 2022 18:49:41 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fad2h0kxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 18:49:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 238IlHhC027096;
        Fri, 8 Apr 2022 18:49:39 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3f6e4949sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 18:49:39 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 238IbGae52953402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Apr 2022 18:37:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A035A404D;
        Fri,  8 Apr 2022 18:49:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 406ADA4040;
        Fri,  8 Apr 2022 18:49:34 +0000 (GMT)
Received: from sig-9-65-90-167.ibm.com (unknown [9.65.90.167])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Apr 2022 18:49:34 +0000 (GMT)
Message-ID: <986199739ff8bd730b9aabe8882e245946d3d9e9.camel@linux.ibm.com>
Subject: Re: [PATCH 4/7] KEYS: Introduce a builtin root of trust key flag
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>, "tiwai@suse.de" <tiwai@suse.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Fri, 08 Apr 2022 14:49:33 -0400
In-Reply-To: <16DDA7F1-95BA-4279-BE4E-9F713A905B36@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
         <20220406015337.4000739-5-eric.snowberg@oracle.com>
         <4fbef0889d6f286c7fcd317db099b4857e1b2fa3.camel@linux.ibm.com>
         <EF1544D5-54E8-4D47-82F8-F9337CA7AEA0@oracle.com>
         <b8965652274b49ba7c6f67cad6d42965cf984b42.camel@linux.ibm.com>
         <16DDA7F1-95BA-4279-BE4E-9F713A905B36@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j72oO1op68dHqRXF_fBHlV6R3iEnrkel
X-Proofpoint-GUID: 96N4JVPRA1gUBy_W7LJmM3Pjp_JTe3LJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_07,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-04-08 at 17:34 +0000, Eric Snowberg wrote:
> 
> > On Apr 8, 2022, at 10:55 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Fri, 2022-04-08 at 15:27 +0000, Eric Snowberg wrote:
> >> 
> >>> On Apr 8, 2022, at 8:40 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>> 
> >>> On Tue, 2022-04-05 at 21:53 -0400, Eric Snowberg wrote:
> >>>> 
> >>>> The first type of key to use this is X.509.  When a X.509 certificate
> >>>> is self signed, has the kernCertSign Key Usage set and contains the
> >>>> CA bit set this new flag is set.
> >>>> 
> >>>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> >>>> 
> >>>> diff --git a/include/linux/key.h b/include/linux/key.h
> >>>> index 7febc4881363..97f6a1f86a27 100644
> >>>> --- a/include/linux/key.h
> >>>> +++ b/include/linux/key.h
> >>>> @@ -230,6 +230,7 @@ struct key {
> >>>> #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
> >>>> #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
> >>>> #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
> >>>> +#define KEY_FLAG_BUILTIN_ROT	10	/* set if key is a builtin Root of Trust key */
> >>>> 
> >>>> 	/* the key type and key description string
> >>>> 	 * - the desc is used to match a key against search criteria
> >>>> @@ -290,6 +291,7 @@ extern struct key *key_alloc(struct key_type *type,
> >>>> #define KEY_ALLOC_BYPASS_RESTRICTION	0x0008	/* Override the check on restricted keyrings */
> >>>> #define KEY_ALLOC_UID_KEYRING		0x0010	/* allocating a user or user session keyring */
> >>>> #define KEY_ALLOC_SET_KEEP		0x0020	/* Set the KEEP flag on the key/keyring */
> >>>> +#define KEY_ALLOC_BUILT_IN_ROT		0x0040  /* Add builtin root of trust key */
> >>> 
> >>> Since the concept of root of trust is not generic, but limited to
> >>> specific keyrings, the root CA certificate signing keys on the
> >>> "machine" keyring need to be identified.  Similar to the
> >>> KEY_ALLOC_BUILT_IN/KEY_FLAG_BUILTIN, new flags
> >>> KEY_ALLOC_MACHINE/KEY_FLAG_MACHINE should be defined instead.
> >> 
> >> I’m open to renaming these, however this name change seems confusing to me.  
> >> This flag gets set when the X.509 certificate contains the three CA requirements 
> >> identified above.  The remaining keys in the machine keyring can be used for 
> >> anything else.
> > 
> > Renaming the flag to KEY_ALLOC_MACHINE/KEY_FLAG_MACHINE differentiates
> > between the "builtin" keys from the "machine" keys.  The trust models
> > are very different.
> 
> Isn’t the trust model the same for machine and secondary keys?  Both are supplied by 
> the end-user. That is why I’m confused by naming something _MACHINE when it applies 
> to more than one keyring.

True both are supplied by the end-user, but the trust models are
different.  In one case the certificates are coming indirectly from
firmware, while in the other case the certificates would be limited to
certificates signed by the initial firmware certificates.  Loading only
root-CA signing key certificates onto the "machine" keyring highlights
and enforces the different types of trust.

> 
> >> Plus this flag can be set for keys loaded into the secondary trusted 
> >> keyring (6th patch in the series).  When an intermediate CA gets loaded into the 
> >> secondary, the flag is set as well.
> > 
> > Please include a full explanation with the motivation in the patch
> > description as to why support for intermediary CAs is required for the
> > "end-user" use case.
> 
> Ok, I can add it.  I thought this was an expectation, based on the help section of
> IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY:
> 
> " Intermediate keys between those the kernel has compiled in and the 
>  IMA keys to be added may be added to the system secondary keyring,
>  provided they are validly signed by a key already resident in the
>  built-in or secondary trusted keyrings."

This paragraph refers to keys on the "builtin_trusted_keys" keyring. 
The concept would need to be expanded to include keys on the "machine"
keyring.   Since support for intermediary CA keys isn't required for
the simple "end-user" use case, the motivation  needs to be provided.

thanks,

Mimi

