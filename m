Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897056274F9
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 04:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiKNDcf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 22:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiKNDce (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 22:32:34 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869B515827;
        Sun, 13 Nov 2022 19:32:33 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AE3NxXv006085;
        Mon, 14 Nov 2022 03:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=KNYKtfhY2k43JD+ZIBssS/J+6Fx6ZqiG51NxfYROhzo=;
 b=IK0ACtLop+d0ZJvSD9iF9pKOM/7UvZVNPFjIKEjRA5sQ85dlvaWH5akxP0r+Dv83WZq6
 j6godVft4sBmqQE30TIUUyuMs1Em62NQTXwSX4vgDPdo+TFYwToxwyuwIII6d494OH22
 mG+i5uBtFo1R3LyJqnYzVEy5xhe9Rod4ylw6Qhg69BHa34coYIIxZ1UHQhk3dSbFih/1
 79BBZOEELbTa1VkB93d/QCUe3v82tluTh8TseMVMARYRJvcbmNFCwKRwJt4NuJmFnEnc
 TsmLtFELlS7pgDbPkhlN6PtUnvJYchuWet5xmzYi6vGjGfs2hHaDwOs7eGRNkoN9q7vQ uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kudr204c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 03:32:09 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AE3W8Up000995;
        Mon, 14 Nov 2022 03:32:08 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kudr204bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 03:32:08 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AE3LIIm024529;
        Mon, 14 Nov 2022 03:32:07 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 3kt349e1d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 03:32:07 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AE3W65f34734616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 03:32:06 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1AB47805E;
        Mon, 14 Nov 2022 04:29:10 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43A8C7805C;
        Mon, 14 Nov 2022 04:29:06 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.83.197])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 04:29:05 +0000 (GMT)
Message-ID: <ff23b4e24222037959c2a784496c7ee91024e6c5.camel@linux.ibm.com>
Subject: Re: [PATCH v5 04/11] security: keys: trusted: Include TPM2 creation
 data
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Eric Biggers <ebiggers@kernel.org>,
        Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        linux-pm@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Sun, 13 Nov 2022 22:32:00 -0500
In-Reply-To: <Y3FfhrgvBNey6T7V@sol.localdomain>
References: <20221111231636.3748636-1-evgreen@chromium.org>
         <20221111151451.v5.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
         <Y3FfhrgvBNey6T7V@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9zY-iV916FvnaPEWaeBOeG_pA_xYejKd
X-Proofpoint-GUID: G_SgRPlbC6_1fY8Mz3XvyT83D3yESpJv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_02,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140019
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2022-11-13 at 13:20 -0800, Eric Biggers wrote:
> On Fri, Nov 11, 2022 at 03:16:29PM -0800, Evan Green wrote:
> > diff --git a/security/keys/trusted-keys/tpm2key.asn1
> > b/security/keys/trusted-keys/tpm2key.asn1
> > index f57f869ad60068..608f8d9ca95fa8 100644
> > --- a/security/keys/trusted-keys/tpm2key.asn1
> > +++ b/security/keys/trusted-keys/tpm2key.asn1
> > @@ -7,5 +7,18 @@ TPMKey ::= SEQUENCE {
> >         emptyAuth       [0] EXPLICIT BOOLEAN OPTIONAL,
> >         parent          INTEGER ({tpm2_key_parent}),
> >         pubkey          OCTET STRING ({tpm2_key_pub}),
> > -       privkey         OCTET STRING ({tpm2_key_priv})
> > +       privkey         OCTET STRING ({tpm2_key_priv}),
> > +       ---
> > +       --- A TPM2B_CREATION_DATA struct as returned from the
> > TPM2_Create command.
> > +       ---
> > +       creationData    [1] EXPLICIT OCTET STRING OPTIONAL
> > ({tpm2_key_creation_data}),
> > +       ---
> > +       --- A TPM2B_DIGEST of the creationHash as returned from the
> > TPM2_Create
> > +       --- command.
> > +       ---
> > +       creationHash    [2] EXPLICIT OCTET STRING OPTIONAL
> > ({tpm2_key_creation_hash}),
> > +       ---
> > +       --- A TPMT_TK_CREATION ticket as returned from the
> > TPM2_Create command.
> > +       ---
> > +       creationTk      [3] EXPLICIT OCTET STRING OPTIONAL
> > ({tpm2_key_creation_tk})
> >         }
> 
> The commit that added this file claimed:
> 
>         "The benefit of the ASN.1 format is that it's a standard and
> thus the
>         exported key can be used by userspace tools
> (openssl_tpm2_engine,
>         openconnect and tpm2-tss-engine"
> 
> Are these new fields in compliance with whatever standard that was
> referring to?

Not really, no.  The current use case (and draft standard) is already
using [1] for policies and [2] for importable keys:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/tree/doc/draft-bottomley-tpm2-keys.xml

I'm actually planning to use [3] for signed policies.  There's no
reason why you can't use [4] though.  Since the creation data, hash and
ticket are likely used as a job lot, it strikes me they should be a
single numbered optional sequence instead of individually numbered,
since you're unlikely to have one without the others.

James

