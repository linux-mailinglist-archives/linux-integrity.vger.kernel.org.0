Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B344F9869
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Apr 2022 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiDHOn5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Apr 2022 10:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiDHOny (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Apr 2022 10:43:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0E7EEA5B;
        Fri,  8 Apr 2022 07:41:51 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238CKHmV010098;
        Fri, 8 Apr 2022 14:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=LKTCnfd0xdy6aUmMv3T2P48F4pb9yvlREuWs2k+iw1k=;
 b=AF95kqREk6r3rk/f3rCAAEPoCWmIyH6VkY6HKWYchgGodOZ22LQoi4DnrF2coGshn32Y
 Z+vPYtQCYOqJ89PvFFt57hpnM8nMWvUaenak5rTVK06abHQMpEta8IN8rdSN+BqprZWy
 RQXNw3F/DT6GEt+XOiwBVgRzlpX8tZDySKYS2DBvUs9aopHvUFxXF+9jaxFBHA1igVYP
 GT1eoaMLGSMFxGoJy7Tb2hqhywnHZ1KMzL+pvlibKh1vBrddlFbqh3TNy+dqDexwnQH1
 dvjjN7Irez8rU5Glf4a5xbKTNP3B7EWL74MDDJpHA0J4qcgfNfcRM7MQI3oLy8tCVOv+ 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fa8mwgfpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:41:34 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 238DlTKH030829;
        Fri, 8 Apr 2022 14:41:33 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fa8mwgfnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:41:33 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 238EbEss014316;
        Fri, 8 Apr 2022 14:41:31 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3f6e493yts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:41:30 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 238ET8uj38863198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Apr 2022 14:29:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CE275205A;
        Fri,  8 Apr 2022 14:41:28 +0000 (GMT)
Received: from sig-9-65-90-167.ibm.com (unknown [9.65.90.167])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AC48452050;
        Fri,  8 Apr 2022 14:41:26 +0000 (GMT)
Message-ID: <fd5e88eb66db909ddc9f2fe6d788465a51a979b4.camel@linux.ibm.com>
Subject: Re: [PATCH 0/7] Add CA enforcement keyring restrictions
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
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>, "tiwai@suse.de" <tiwai@suse.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Fri, 08 Apr 2022 10:41:26 -0400
In-Reply-To: <8ECDC8D2-433B-4F7E-9EEC-BB85C75ED198@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
         <6bfe3fe98eb7c11520264503fd10da478d6a3fd3.camel@linux.ibm.com>
         <8ECDC8D2-433B-4F7E-9EEC-BB85C75ED198@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8_3-dRJnYlkU-lia-ZcSZ5-MRuMhyLt0
X-Proofpoint-GUID: aX1itNTZAWSDZxHj7uUhB3ii07gWC1-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_05,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=965 impostorscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-04-06 at 22:53 +0000, Eric Snowberg wrote:
> 
> > On Apr 6, 2022, at 2:45 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > Hi Eric,
> > 
> > On Tue, 2022-04-05 at 21:53 -0400, Eric Snowberg wrote:
> >> A key added to the ima keyring must be signed by a key contained within 
> >> either the builtin trusted or secondary trusted keyrings. Currently, there are 
> >> CA restrictions described in IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY,
> >> but these restrictions are not enforced within code. Therefore, keys within 
> >> either the builtin or secondary may not be a CA and could be used to
> >> vouch for an ima key.
> >> 
> >> The machine keyring can not be used as another trust anchor for adding keys 
> >> to the ima keyring, since CA enforcement does not currently exist [1]. This 
> >> would expand the current integrity gap.
> >> 
> >> Introduce a new root of trust key flag to close this integrity gap for
> >> all keyrings.  The first key type to use this is X.509.  When a X.509 
> >> certificate is self signed, contains kernCertSign Key Usage and contains 
> >> the CA bit, the new flag is set.  Introduce new keyring restrictions 
> >> that not only validates a key is signed by a key contained within the 
> >> keyring, but also validates the key has the new root of trust key flag 
> >> set.  Use this new restriction for keys added to the ima keyring.  Now 
> >> that we have CA enforcement, allow the machine keyring to be used as another 
> >> trust anchor for the ima keyring.
> >> 
> >> To recap, all keys that previously loaded into the builtin, secondary or
> >> machine keyring will still load after applying this series.  Keys
> >> contained within these keyrings may carry the root of trust flag. The
> >> ima keyring will use the new root of trust restriction to validate
> >> CA enforcement. Other keyrings that require a root of trust could also 
> >> use this in the future.
> > 
> > Your initial patch set indicated that you were addressing Linus'
> > request to allow end-users the ability "to add their own keys and sign
> > modules they trust".  However, from the design of the previous patch
> > set and now this one, everything indicates a lot more is going on than
> > just allowing end-users to add their own keys.  There would be no
> > reason for loading all the MOK keys, rather than just the CA keys, onto
> > the "machine" keyring.  Please provide the motivation for this design.
> 
> The motivation is to satisfy both Linus and your requests. Linus requested 
> the ability to allow users to add their own keys and sign modules they trust.  
> A code signing CA certificate does not require kernCertSign in the usage. Adding 
> this as a requirement for kernel modules would be a regression (or a bug).

Of course a code signing CA certificate should not also be a
certificate signing key (keyCertSign).  Remember the
"builtin_trusted_keys" and "secondary_trusted_keys" keyrings are
special.  Their root of trust is based on a secure boot signature chain
of trust up to and including a signed kernel image.  The "machine"
keyring is totally different in this regard.  Establishing a new root
of trust is really difficult.  Requiring a root-CA to have key
certifcate signing usage is a level of indirection, which I would
consider a small price to pay for being able to establish a, hopefully
safe or at least safer, new root of trust for trusting "end-user" keys.

> 
> This series addresses your request to only trust validly signed CA certs. 
> As you pointed out in the Kconfig help for 
> IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY:
> 
> help
>   Keys may be added to the IMA or IMA blacklist keyrings, if the
>   key is validly signed by a CA cert in the system built-in or
>   secondary trusted keyrings.
> 
>   Intermediate keys between those the kernel has compiled in and the 
>   IMA keys to be added may be added to the system secondary keyring,
>   provided they are validly signed by a key already resident in the
>   built-in or secondary trusted keyrings.
> 
> requires keys to be “validly” signed by a CA cert. Later the definition of a 
> validly signed CA cert was defined as: self signed, contains kernCertSign 
> key usage and contains the CA bit. While this help file states the CA restriction, 
> nothing in code enforces it.  One can place any type of self signed cert in either 
> keyring and ima will use it.  The motivation is for all keys added to the ima 
> keyring to abide by the restriction defined in the Kconfig help.  With this series 
> this can be accomplished without introducing a regression on keys placed in 
> any of the system keyrings.
> 
> > Please note that Patch 6/7 permits intermediary CA keys, without any
> > mention of it in the cover letter.  Please include this in the
> > motivation for this design.
> 
> Ok, I’ll add that in the next round.

Your cover letter should say that this patch series enables
verification of 3rd party modules.

thanks,

Mimi

