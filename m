Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F546C22E2
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Mar 2023 21:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCTUgm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Mar 2023 16:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjCTUge (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Mar 2023 16:36:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3702FCD1;
        Mon, 20 Mar 2023 13:36:14 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KKFS8v021944;
        Mon, 20 Mar 2023 20:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=b4EsHisSM6dNxIEpDD9ukTMeDjGa/aILuPEgRRZ0YaU=;
 b=rcAw8lNInFWVvgZ9qd8RJjHnc+ahTP15ecAorh5D4OClETIbw5iCprvvV8dlj/G9f5fB
 Q1hVhmV6yKKjRGzEO3VGfLStVV4CozgHyH+OhVBrxoZ+hKPaPerEs5722aarP6p482Mk
 +0JavtH1JX9vfBblstY/t72ogdqUnrjYZLhZQix+xs2iuGPX9TvjXHIDAceOgOh4i4fY
 KrZ7oL/Y9VTwngTv4eBLvsvanoEQ2xbtHDfESZoWfniGv/zKuVbWuqvU2kfDDsJY5Sop
 0Uk9CFmDBb5/3leDbrXFcJ63YTZRJkxpG1evq4E3XwN8bCRYNAHW8ZKq48ioeylOQo3+ eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pevekcajv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 20:35:39 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32KKDmnF010835;
        Mon, 20 Mar 2023 20:35:38 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pevekcajj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 20:35:38 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32KJ9JrK022620;
        Mon, 20 Mar 2023 20:35:37 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x6prtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 20:35:37 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32KKZaSD26345844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 20:35:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B285258045;
        Mon, 20 Mar 2023 20:35:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEA7558054;
        Mon, 20 Mar 2023 20:35:33 +0000 (GMT)
Received: from sig-9-65-214-169.ibm.com (unknown [9.65.214.169])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Mar 2023 20:35:33 +0000 (GMT)
Message-ID: <84d46fb108f6ce2a322b6486529fc6dd0f8deea5.camel@linux.ibm.com>
Subject: Re: [PATCH v5 5/6] KEYS: CA link restriction
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     David Howells <dhowells@redhat.com>,
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
Date:   Mon, 20 Mar 2023 16:35:33 -0400
In-Reply-To: <20230320182822.6xyh6ibatrz5yrhb@kernel.org>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
         <20230302164652.83571-6-eric.snowberg@oracle.com>
         <ZAz8QlynTSMD7kuE@kernel.org>
         <07FFED83-501D-418C-A4BB-862A547DD7B0@oracle.com>
         <20230320182822.6xyh6ibatrz5yrhb@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RYrTid9Y4dDrlCFlblE-R68GyJhJmpEc
X-Proofpoint-ORIG-GUID: Sg6y4qrDLdNPkCDytCT0qvkqxTJniA98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200174
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-03-20 at 20:28 +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 20, 2023 at 05:35:05PM +0000, Eric Snowberg wrote:
> > 
> > 
> > > On Mar 11, 2023, at 3:10 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > 
> > > On Thu, Mar 02, 2023 at 11:46:51AM -0500, Eric Snowberg wrote:
> > >> Add a new link restriction.  Restrict the addition of keys in a keyring
> > >> based on the key to be added being a CA.
> > >> 
> > >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > >> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > >> ---
> > >> crypto/asymmetric_keys/restrict.c | 38 +++++++++++++++++++++++++++++++
> > >> include/crypto/public_key.h       | 15 ++++++++++++
> > >> 2 files changed, 53 insertions(+)
> > >> 
> > >> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
> > >> index 6b1ac5f5896a..48457c6f33f9 100644
> > >> --- a/crypto/asymmetric_keys/restrict.c
> > >> +++ b/crypto/asymmetric_keys/restrict.c
> > >> @@ -108,6 +108,44 @@ int restrict_link_by_signature(struct key *dest_keyring,
> > >> 	return ret;
> > >> }
> > >> 
> > >> +/**
> > >> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
> > >> + * @dest_keyring: Keyring being linked to.
> > >> + * @type: The type of key being added.
> > >> + * @payload: The payload of the new key.
> > >> + * @trust_keyring: Unused.
> > >> + *
> > >> + * Check if the new certificate is a CA. If it is a CA, then mark the new
> > >> + * certificate as being ok to link.
> > >> + *
> > >> + * Returns 0 if the new certificate was accepted, -ENOKEY if the
> > >> + * certificate is not a CA. -ENOPKG if the signature uses unsupported
> > >> + * crypto, or some other error if there is a matching certificate but
> > >> + * the signature check cannot be performed.
> > >> + */
> > >> +int restrict_link_by_ca(struct key *dest_keyring,
> > >> +			const struct key_type *type,
> > >> +			const union key_payload *payload,
> > >> +			struct key *trust_keyring)
> > >> +{
> > >> +	const struct public_key *pkey;
> > >> +
> > >> +	if (type != &key_type_asymmetric)
> > >> +		return -EOPNOTSUPP;
> > >> +
> > >> +	pkey = payload->data[asym_crypto];
> > >> +	if (!pkey)
> > >> +		return -ENOPKG;
> > >> +	if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
> > >> +		return -ENOKEY;
> > >> +	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
> > >> +		return -ENOKEY;
> > >> +	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
> > >> +		return -ENOKEY;
> > > 
> > > nit: would be more readable, if conditions were separated by
> > > empty lines.
> > 
> > Ok, I will make this change in the next round.  Thanks.
> 
> Cool! Mimi have you tested these patches with IMA applied?

Yes, it's working as expected.

-- 
Mimi

