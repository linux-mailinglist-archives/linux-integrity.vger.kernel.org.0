Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E28F502D90
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Apr 2022 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355760AbiDOQRy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Apr 2022 12:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355822AbiDOQRp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Apr 2022 12:17:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F41F95A35;
        Fri, 15 Apr 2022 09:15:16 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23FEsYZs006010;
        Fri, 15 Apr 2022 16:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UWTIYmrEftbLWJ6XCjLqKzy6zE8O8MmJwK2RB40wCX0=;
 b=GzERIESg5aYp7Igqk+Ju9n6r2wA04zssnpBGCoVdrNXJSrlPY+dFeeZzQT9Fda9dv3Pe
 ZDi67zzS/mjO4n1moq3BrOYCN6ombcz6K7aBCJH2E8JJvl59Ho0LqYsFYt0cmdHQwso1
 F8nfUWPLlHYyy5kO6Q81TOBZMzIUY8SdFywR3/9KH6rZozCMpuTih7R7XJo7twib5tcP
 iW3IPinDuaSFjilyXRFo2fpiN/z9RsHSVnSzhoyz2+iJjDcHlDp1IiOM75z6WcY6zhGU
 BhvGdY7ik+1dHYBSFuXGry31eoMyyAfL2aU/CP8O9p0C2EkpMcm/vkUy6rQ067o1mUlp 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fedxth8jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 16:14:17 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23FFxgu0004430;
        Fri, 15 Apr 2022 16:14:17 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fedxth8ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 16:14:17 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23FFsCiO009562;
        Fri, 15 Apr 2022 16:14:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3fb1s8rnfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 16:14:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23FGECIP35258678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 16:14:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0BB24C04A;
        Fri, 15 Apr 2022 16:14:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 496A44C044;
        Fri, 15 Apr 2022 16:14:10 +0000 (GMT)
Received: from sig-9-65-86-1.ibm.com (unknown [9.65.86.1])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Apr 2022 16:14:10 +0000 (GMT)
Message-ID: <faf4f539ca163a0f458a8b9d23f1f6d23a8fea21.camel@linux.ibm.com>
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
Date:   Fri, 15 Apr 2022 12:14:09 -0400
In-Reply-To: <0A0B0B93-80BD-49A9-B0B3-56C6F74D2BE0@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
         <20220406015337.4000739-5-eric.snowberg@oracle.com>
         <4fbef0889d6f286c7fcd317db099b4857e1b2fa3.camel@linux.ibm.com>
         <EF1544D5-54E8-4D47-82F8-F9337CA7AEA0@oracle.com>
         <b8965652274b49ba7c6f67cad6d42965cf984b42.camel@linux.ibm.com>
         <16DDA7F1-95BA-4279-BE4E-9F713A905B36@oracle.com>
         <986199739ff8bd730b9aabe8882e245946d3d9e9.camel@linux.ibm.com>
         <BFA04505-F4BC-4CF8-B813-EE81DBD90E09@oracle.com>
         <6798c67d748ecdc92455a8be8c63fb55e243368a.camel@linux.ibm.com>
         <B67D99B1-1DF9-4146-9147-08B2C4A72FEA@oracle.com>
         <909b435d947070b44e66e7e8a10951972fc3da7b.camel@linux.ibm.com>
         <0A0B0B93-80BD-49A9-B0B3-56C6F74D2BE0@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ziH38Z-OoTUwMmE8yfdLa-pHsc1HGAo8
X-Proofpoint-GUID: xlYX5krNaH4nMQ7dc99L2jxRQeumkgDT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-15_06,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-04-14 at 21:59 +0000, Eric Snowberg wrote:
> 
> > On Apr 14, 2022, at 12:09 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Thu, 2022-04-14 at 16:36 +0000, Eric Snowberg wrote:
> >> 
> >>> On Apr 11, 2022, at 9:30 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>> 
> >>> On Fri, 2022-04-08 at 21:59 +0000, Eric Snowberg wrote:
> >>>>> On Apr 8, 2022, at 12:49 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>>> 
> >>>>> On Fri, 2022-04-08 at 17:34 +0000, Eric Snowberg wrote:
> >>>>>> 
> >>>>>>> On Apr 8, 2022, at 10:55 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>>>>> 
> >>>>>>> On Fri, 2022-04-08 at 15:27 +0000, Eric Snowberg wrote:
> >>>>>>>> 
> >>>>>>>>> On Apr 8, 2022, at 8:40 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>>>>>>> 
> >>>>>>>>> On Tue, 2022-04-05 at 21:53 -0400, Eric Snowberg wrote:
> >>>>>>>>>> 
> >>>>>>>>>> The first type of key to use this is X.509.  When a X.509 certificate
> >>>>>>>>>> is self signed, has the kernCertSign Key Usage set and contains the
> >>>>>>>>>> CA bit set this new flag is set.
> >>>>>>>>>> 
> >>>>>>>>>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> >>>>>>>>>> 
> >>>>>>>>>> diff --git a/include/linux/key.h b/include/linux/key.h
> >>>>>>>>>> index 7febc4881363..97f6a1f86a27 100644
> >>>>>>>>>> --- a/include/linux/key.h
> >>>>>>>>>> +++ b/include/linux/key.h
> >>>>>>>>>> @@ -230,6 +230,7 @@ struct key {
> >>>>>>>>>> #define KEY_FLAG_ROOT_CAN_INVAL  7       /* set if key can be invalidated by root without permission */
> >>>>>>>>>> #define KEY_FLAG_KEEP            8       /* set if key should not be removed */
> >>>>>>>>>> #define KEY_FLAG_UID_KEYRING     9       /* set if key is a user or user session keyring */
> >>>>>>>>>> +#define KEY_FLAG_BUILTIN_ROT    10      /* set if key is a builtin Root of Trust key */
> >>>>>>>>>> 
> >>>>>>>>>> /* the key type and key description string
> >>>>>>>>>> * - the desc is used to match a key against search criteria
> >>>>>>>>>> @@ -290,6 +291,7 @@ extern struct key *key_alloc(struct key_type *type,
> >>>>>>>>>> #define KEY_ALLOC_BYPASS_RESTRICTION     0x0008  /* Override the check on restricted keyrings */
> >>>>>>>>>> #define KEY_ALLOC_UID_KEYRING            0x0010  /* allocating a user or user session keyring */
> >>>>>>>>>> #define KEY_ALLOC_SET_KEEP               0x0020  /* Set the KEEP flag on the key/keyring */
> >>>>>>>>>> +#define KEY_ALLOC_BUILT_IN_ROT          0x0040  /* Add builtin root of trust key */
> >>>>>>>>> 
> >>>>>>>>> Since the concept of root of trust is not generic, but limited to
> >>>>>>>>> specific keyrings, the root CA certificate signing keys on the
> >>>>>>>>> "machine" keyring need to be identified.  Similar to the
> >>>>>>>>> KEY_ALLOC_BUILT_IN/KEY_FLAG_BUILTIN, new flags
> >>>>>>>>> KEY_ALLOC_MACHINE/KEY_FLAG_MACHINE should be defined instead.
> >>>>>>>> 
> >>>>>>>> I’m open to renaming these, however this name change seems confusing to me.  
> >>>>>>>> This flag gets set when the X.509 certificate contains the three CA requirements 
> >>>>>>>> identified above.  The remaining keys in the machine keyring can be used for 
> >>>>>>>> anything else.
> >>>>>>> 
> >>>>>>> Renaming the flag to KEY_ALLOC_MACHINE/KEY_FLAG_MACHINE differentiates
> >>>>>>> between the "builtin" keys from the "machine" keys.  The trust models
> >>>>>>> are very different.
> >>>>>> 
> >>>>>> Isn’t the trust model the same for machine and secondary keys?  Both are supplied by 
> >>>>>> the end-user. That is why I’m confused by naming something _MACHINE when it applies 
> >>>>>> to more than one keyring.
> >>>>> 
> >>>>> True both are supplied by the end-user, but the trust models are
> >>>>> different.
> >>>> 
> >>>> I think I need more information here, I’m not seeing how they are different trust 
> >>>> models.
> >>> 
> >>> In order to discuss trust models, we need to understand the different
> >>> use-cases that are being discussed here without ever having been
> >>> explicitly stated.  Here are a few:
> >>> - Allow users to sign their own kernel modules.
> >>> - Allow users to selectively authorize 3rd party certificates to verify
> >>> kernel modules.
> >>> - From an IMA perspective, allow users to sign files within their own
> >>> software packages.
> >>> 
> >>> Each of the above use-cases needs to be independently configurable,
> >>> thoroughly explained, and enforced.
> >> 
> >> I’m still confused by the request here.  All these use cases can be done 
> >> today with insert-sys-cert.  Take the, " allow user to sign their own kernel 
> >> modules" use case.  Using insert-sys-cert, any type of key can be added 
> >> to the builtin trusted keyring, it doesn’t need to be self signed, there are 
> >> no restrictions on fields in the certificate.  The same approach can be used 
> >> to allow users to ima sign their own files. Any key can be added, it doesn’t 
> >> need to be a CA. The same goes for 3rd party signed modules.
> > 
> > The difference is "where" the key is coming from.  In the builtin use-
> > case or the post build insert-sys-cert case, the kernel image is
> > signed, or re-signed, and the kernel image signature is verified.  The
> > root of trust is straight forward - secure boot with a HW root of trust
> > up to and including verifying the kernel image signature, then
> > transition to the builtin keys.
> > 
> > Keys on the "machine" keyring are not part of that signature chain of
> > trust,
> 
> The machine keyring contains all keys in the MokList. On x86 (and other 
> architectures that boot with shim) all keys in the MokList are part of the signature 
> chain of trust. Shim uses MOKList keys to validate the kernel image signature 
> when booting with SecureBoot enabled. Secure Boot DB keys are used to
> validate shim, but rarely used to validate the kernel.

Sure, keys on the "machine" keyring can be used to verify the kexec
kernel image signature.

As all of the above requirements is satisfied by loading a root CA, def
ined as a KeySigning cert, without needing to load all of the MOK keys
onto the "machine" keyring, support both trust models.  Please make
loading all MOK keys configurable, with a thorough explanation.

thanks,

Mimi

