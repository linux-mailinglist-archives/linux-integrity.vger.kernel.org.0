Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA24FC0C4
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Apr 2022 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347930AbiDKPeS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Apr 2022 11:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348269AbiDKPdo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Apr 2022 11:33:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE8F35DE1;
        Mon, 11 Apr 2022 08:31:29 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BDm2x4016697;
        Mon, 11 Apr 2022 15:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=l9AB7GVsGiap+WlF670Iih31yy9cSLCunm8PRyeTp6U=;
 b=XrfFDWagaHFjztFzzu9hrdCXa0WLKGJsLQTB1fzwS2psGipuokfNbAQEJ487Y+C3RHtb
 mn+ujeaVQZ8tFiw226o1Q22vTesrh3QiItMmFfEFY+GsDT/url56kLbhusWUddW/5g1k
 21f6+Pzq9i9KFJYf4N4H3H+A7qZhq+pZWJt8/e5au1xowI6/c4xO01hfat5VfLrkKmJV
 vgC7zO7E1eZQjkh9DewNxEPqZlJBWkb4nSDvnKO+sut5tEBtzFVY53u2XbF8AbhU/McU
 QOVNZrR1V3fqQH8IOFGrCZY9flNkbrVitneY7ehgrFqXxbmGB5jUpflKxFH5v2vwYn8G gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fcnhhaced-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 15:30:58 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23BEKrsx014370;
        Mon, 11 Apr 2022 15:30:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fcnhhacdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 15:30:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23BFMCs0024027;
        Mon, 11 Apr 2022 15:30:53 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3fb1s8ucdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 15:30:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23BFUpN745154646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 15:30:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2069F52050;
        Mon, 11 Apr 2022 15:30:51 +0000 (GMT)
Received: from sig-9-65-89-227.ibm.com (unknown [9.65.89.227])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B72E95204F;
        Mon, 11 Apr 2022 15:30:48 +0000 (GMT)
Message-ID: <6798c67d748ecdc92455a8be8c63fb55e243368a.camel@linux.ibm.com>
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
Date:   Mon, 11 Apr 2022 11:30:48 -0400
In-Reply-To: <BFA04505-F4BC-4CF8-B813-EE81DBD90E09@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
         <20220406015337.4000739-5-eric.snowberg@oracle.com>
         <4fbef0889d6f286c7fcd317db099b4857e1b2fa3.camel@linux.ibm.com>
         <EF1544D5-54E8-4D47-82F8-F9337CA7AEA0@oracle.com>
         <b8965652274b49ba7c6f67cad6d42965cf984b42.camel@linux.ibm.com>
         <16DDA7F1-95BA-4279-BE4E-9F713A905B36@oracle.com>
         <986199739ff8bd730b9aabe8882e245946d3d9e9.camel@linux.ibm.com>
         <BFA04505-F4BC-4CF8-B813-EE81DBD90E09@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Onkk5hMhE7Dop4lPIT_dAQZd5PBFSuf7
X-Proofpoint-ORIG-GUID: f9XCZDuQK4ykRc0vIg5oq3JqbAZx1R-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-11_06,2022-04-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-04-08 at 21:59 +0000, Eric Snowberg wrote:
> > On Apr 8, 2022, at 12:49 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Fri, 2022-04-08 at 17:34 +0000, Eric Snowberg wrote:
> >> 
> >>> On Apr 8, 2022, at 10:55 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>> 
> >>> On Fri, 2022-04-08 at 15:27 +0000, Eric Snowberg wrote:
> >>>> 
> >>>>> On Apr 8, 2022, at 8:40 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>>> 
> >>>>> On Tue, 2022-04-05 at 21:53 -0400, Eric Snowberg wrote:
> >>>>>> 
> >>>>>> The first type of key to use this is X.509.  When a X.509 certificate
> >>>>>> is self signed, has the kernCertSign Key Usage set and contains the
> >>>>>> CA bit set this new flag is set.
> >>>>>> 
> >>>>>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> >>>>>> 
> >>>>>> diff --git a/include/linux/key.h b/include/linux/key.h
> >>>>>> index 7febc4881363..97f6a1f86a27 100644
> >>>>>> --- a/include/linux/key.h
> >>>>>> +++ b/include/linux/key.h
> >>>>>> @@ -230,6 +230,7 @@ struct key {
> >>>>>> #define KEY_FLAG_ROOT_CAN_INVAL  7       /* set if key can be invalidated by root without permission */
> >>>>>> #define KEY_FLAG_KEEP            8       /* set if key should not be removed */
> >>>>>> #define KEY_FLAG_UID_KEYRING     9       /* set if key is a user or user session keyring */
> >>>>>> +#define KEY_FLAG_BUILTIN_ROT    10      /* set if key is a builtin Root of Trust key */
> >>>>>> 
> >>>>>>  /* the key type and key description string
> >>>>>>   * - the desc is used to match a key against search criteria
> >>>>>> @@ -290,6 +291,7 @@ extern struct key *key_alloc(struct key_type *type,
> >>>>>> #define KEY_ALLOC_BYPASS_RESTRICTION     0x0008  /* Override the check on restricted keyrings */
> >>>>>> #define KEY_ALLOC_UID_KEYRING            0x0010  /* allocating a user or user session keyring */
> >>>>>> #define KEY_ALLOC_SET_KEEP               0x0020  /* Set the KEEP flag on the key/keyring */
> >>>>>> +#define KEY_ALLOC_BUILT_IN_ROT          0x0040  /* Add builtin root of trust key */
> >>>>> 
> >>>>> Since the concept of root of trust is not generic, but limited to
> >>>>> specific keyrings, the root CA certificate signing keys on the
> >>>>> "machine" keyring need to be identified.  Similar to the
> >>>>> KEY_ALLOC_BUILT_IN/KEY_FLAG_BUILTIN, new flags
> >>>>> KEY_ALLOC_MACHINE/KEY_FLAG_MACHINE should be defined instead.
> >>>> 
> >>>> I’m open to renaming these, however this name change seems confusing to me.  
> >>>> This flag gets set when the X.509 certificate contains the three CA requirements 
> >>>> identified above.  The remaining keys in the machine keyring can be used for 
> >>>> anything else.
> >>> 
> >>> Renaming the flag to KEY_ALLOC_MACHINE/KEY_FLAG_MACHINE differentiates
> >>> between the "builtin" keys from the "machine" keys.  The trust models
> >>> are very different.
> >> 
> >> Isn’t the trust model the same for machine and secondary keys?  Both are supplied by 
> >> the end-user. That is why I’m confused by naming something _MACHINE when it applies 
> >> to more than one keyring.
> > 
> > True both are supplied by the end-user, but the trust models are
> > different.
> 
> I think I need more information here, I’m not seeing how they are different trust 
> models.

In order to discuss trust models, we need to understand the different
use-cases that are being discussed here without ever having been
explicitly stated.  Here are a few:
- Allow users to sign their own kernel modules.
- Allow users to selectively authorize 3rd party certificates to verify
kernel modules.
- From an IMA perspective, allow users to sign files within their own
software packages.

Each of the above use-cases needs to be independently configurable,
thoroughly explained, and enforced.

thanks,

Mimi


> 
> >  In one case the certificates are coming indirectly from
> > firmware,

