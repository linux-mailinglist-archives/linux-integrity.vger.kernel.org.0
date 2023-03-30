Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37C96CFB2D
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Mar 2023 08:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjC3GCp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Mar 2023 02:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjC3GCo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Mar 2023 02:02:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0E761B5;
        Wed, 29 Mar 2023 23:02:30 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32U5cVhZ015618;
        Thu, 30 Mar 2023 06:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=D8BLJKqTKr4rrKXsGkt3MWAUhN1P3ddzzG00QTMTrcA=;
 b=CIgbVvP8nY4lSzLuwgFNXcbkpi0+yT2OAzGlRC+5Xf1sH7i6BE+m1AZPjX0MYkzPllSt
 iNNjguigA39uPBENAZfX1cB+KjR28PFsjmCGwPLFGJr49g9+YGRqtNtv96m0zXmA2p4d
 UfEKZUxd5z5TVgV4ugp9aELRGs0Xpk/1fJNSBTUXQyp4TrDXBDpSw+gW8CsoGig1rPO1
 mRNiPHxZw7YXc8+AY1VbYpXdoCETJtfUyM1n24NZ/dq9O7G2hjSXiOPCcyc+vyAkox/t
 bA17STqHKwXVy9rH7r+tte/exp1PVFL9ImCHQP5hWw5D4uXi3zzD/ZgQI6UxmPCMGWck rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmph951bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 06:02:01 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32U5qwwR026070;
        Thu, 30 Mar 2023 06:02:01 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmph951au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 06:02:00 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32U2JgfY002608;
        Thu, 30 Mar 2023 06:01:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3phrk7jc4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 06:01:59 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32U61wF239322280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 06:01:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AFCF580FF;
        Thu, 30 Mar 2023 06:01:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE5DF580F9;
        Thu, 30 Mar 2023 06:01:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.174.114])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 30 Mar 2023 06:01:53 +0000 (GMT)
Message-ID: <55b5c21ee1cf47aff0b2e5a94ec65fe326c8d6ba.camel@linux.ibm.com>
Subject: Re: [PATCH v5 5/6] KEYS: CA link restriction
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "erpalmer@linux.vnet.ibm.com" <erpalmer@linux.vnet.ibm.com>,
        "coxu@redhat.com" <coxu@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Thu, 30 Mar 2023 02:01:52 -0400
In-Reply-To: <20230329232735.dvmxvwis2psbvyw5@kernel.org>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
         <20230302164652.83571-6-eric.snowberg@oracle.com>
         <ZAz8QlynTSMD7kuE@kernel.org>
         <07FFED83-501D-418C-A4BB-862A547DD7B0@oracle.com>
         <20230320182822.6xyh6ibatrz5yrhb@kernel.org>
         <84d46fb108f6ce2a322b6486529fc6dd0f8deea5.camel@linux.ibm.com>
         <20230329232735.dvmxvwis2psbvyw5@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -AYgNS0hJQzkaFq2dbj8oeeSCLCBxsU7
X-Proofpoint-ORIG-GUID: dV2z4ZQOEAl_wn7WkpC7Te5PoSYskE6S
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_02,2023-03-30_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300047
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-03-30 at 02:27 +0300, Jarkko Sakkinen wrote:
> On Mon, Mar 20, 2023 at 04:35:33PM -0400, Mimi Zohar wrote:
> > On Mon, 2023-03-20 at 20:28 +0200, Jarkko Sakkinen wrote:
> > > On Mon, Mar 20, 2023 at 05:35:05PM +0000, Eric Snowberg wrote:
> > > > 
> > > > 
> > > > > On Mar 11, 2023, at 3:10 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > 
> > > > > On Thu, Mar 02, 2023 at 11:46:51AM -0500, Eric Snowberg wrote:
> > > > >> Add a new link restriction.  Restrict the addition of keys in a keyring
> > > > >> based on the key to be added being a CA.
> > > > >> 
> > > > >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > > > >> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > >> ---
> > > > >> crypto/asymmetric_keys/restrict.c | 38 +++++++++++++++++++++++++++++++
> > > > >> include/crypto/public_key.h       | 15 ++++++++++++
> > > > >> 2 files changed, 53 insertions(+)
> > > > >> 
> > > > >> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
> > > > >> index 6b1ac5f5896a..48457c6f33f9 100644
> > > > >> --- a/crypto/asymmetric_keys/restrict.c
> > > > >> +++ b/crypto/asymmetric_keys/restrict.c
> > > > >> @@ -108,6 +108,44 @@ int restrict_link_by_signature(struct key *dest_keyring,
> > > > >> 	return ret;
> > > > >> }
> > > > >> 
> > > > >> +/**
> > > > >> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
> > > > >> + * @dest_keyring: Keyring being linked to.
> > > > >> + * @type: The type of key being added.
> > > > >> + * @payload: The payload of the new key.
> > > > >> + * @trust_keyring: Unused.
> > > > >> + *
> > > > >> + * Check if the new certificate is a CA. If it is a CA, then mark the new
> > > > >> + * certificate as being ok to link.
> > > > >> + *
> > > > >> + * Returns 0 if the new certificate was accepted, -ENOKEY if the
> > > > >> + * certificate is not a CA. -ENOPKG if the signature uses unsupported
> > > > >> + * crypto, or some other error if there is a matching certificate but
> > > > >> + * the signature check cannot be performed.
> > > > >> + */
> > > > >> +int restrict_link_by_ca(struct key *dest_keyring,
> > > > >> +			const struct key_type *type,
> > > > >> +			const union key_payload *payload,
> > > > >> +			struct key *trust_keyring)
> > > > >> +{
> > > > >> +	const struct public_key *pkey;
> > > > >> +
> > > > >> +	if (type != &key_type_asymmetric)
> > > > >> +		return -EOPNOTSUPP;
> > > > >> +
> > > > >> +	pkey = payload->data[asym_crypto];
> > > > >> +	if (!pkey)
> > > > >> +		return -ENOPKG;
> > > > >> +	if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
> > > > >> +		return -ENOKEY;
> > > > >> +	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
> > > > >> +		return -ENOKEY;
> > > > >> +	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
> > > > >> +		return -ENOKEY;
> > > > > 
> > > > > nit: would be more readable, if conditions were separated by
> > > > > empty lines.
> > > > 
> > > > Ok, I will make this change in the next round.  Thanks.
> > > 
> > > Cool! Mimi have you tested these patches with IMA applied?
> > 
> > Yes, it's working as expected.
> 
> Thank you. Please check that I filled additional tags correctly:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/
> 
> I will then put these also to my 'next' branch and they will get mirrored
> to linux-next.

Thanks, Jarkko.  The tags look good.

-- 
thanks,

Mimi

