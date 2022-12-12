Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1737C64A9AC
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Dec 2022 22:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiLLVo4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Dec 2022 16:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiLLVoy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Dec 2022 16:44:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A9F13E35;
        Mon, 12 Dec 2022 13:44:53 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCKhp1C023462;
        Mon, 12 Dec 2022 21:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Sa/IMRCUcp/NqiNJFzuydVhh4vOLra4e/tBGYGanhFw=;
 b=Fe/eb6Kn9AZQ/kGL6ODzsA50b2vllLCRVzEIyxNAkVI+Ni0TSCTIuLRqtYmOIh3bVEKK
 cUb0ng/pn2r6hWsQFj7frCW2Hssq27Qxm1QCsvkVBdiPV5UorqwISKIog1PTvmUEJxb2
 2nTeD8lX6ierMjWsywrPMmZlX1sdlmF7vFH7HypALrwT9DEuZxD8aYoHVh9MhONVlcL1
 mHOrifEn7ekXiBDdbtZz32k7ryEOF/oyl3F1QCmgjQNA4wcmR8N2/zT5zE+x1ggX7Q83
 PeNIL5eEoVOA7QFIS3Ju88ORJkUyvBrG8JZDnDuZrEi5LQM/fPfyfflzHZHeZpIZpNQe 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mebk7178j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 21:44:27 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BCLUNjE015744;
        Mon, 12 Dec 2022 21:44:26 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mebk7178c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 21:44:26 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.16.1.2) with ESMTP id 2BCKMvBP019461;
        Mon, 12 Dec 2022 21:44:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3mchr6k9e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 21:44:25 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BCLiOfk37552482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 21:44:24 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 369795805A;
        Mon, 12 Dec 2022 21:44:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 696735804E;
        Mon, 12 Dec 2022 21:44:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.60.25])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Dec 2022 21:44:22 +0000 (GMT)
Message-ID: <d9060f9765e59b5fd46c9f7c6a8682a29e712120.camel@linux.ibm.com>
Subject: Re: [PATCH v2 00/10] Add CA enforcement keyring restrictions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Coiby Xu <coxu@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "noodles@fb.com" <noodles@fb.com>, "tiwai@suse.de" <tiwai@suse.de>,
        "bp@suse.de" <bp@suse.de>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Mon, 12 Dec 2022 16:44:22 -0500
In-Reply-To: <5AF81A9E-C4E7-4BEB-86E1-4D2DB613FBF1@oracle.com>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
         <20221209102612.wa3oftpqupzplx6h@Rk>
         <5AF81A9E-C4E7-4BEB-86E1-4D2DB613FBF1@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YIa0V5D9cmF90M6ofJtbgv6Ib7eypmZi
X-Proofpoint-ORIG-GUID: hycEuVe5LoG_BQbYT14ivtjmP1FHOjyX
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=837 lowpriorityscore=0 phishscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120187
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric, Coiby,

On Fri, 2022-12-09 at 15:44 +0000, Eric Snowberg wrote:
> > On Dec 9, 2022, at 3:26 AM, Coiby Xu <coxu@redhat.com> wrote:
> > 
> > Thanks for your work! The patch set looks good to me except for the
> > requirement of an intermediate CA certificate should be vouched for by a
> > root CA certificate before it can vouch for other certificates. What if
> > users only want to enroll an intermediate CA certificate into the MOK?
> 
> This question would need to be answered by the maintainers.  The intermediate 
> requirement was based on my understanding of previous discussions requiring
> there be a way to validate root of trust all the way back to the root CA.

That definitely did not come from me.  My requirement all along has
been to support a single self-signed CA certificate for the end
user/customer use case, so that they could create and load their own
public key, signed by that CA, onto the trusted IMA/EVM keyrings.

> 
> > If this requirement could be dropped, the code could be simplified and
> > some issues could be resolved automatically,
> 
> Agreed. I will make sure the issue below is resolved one way or the other,
> once we have an agreement on the requirements. 

I totally agree with Coiby that there is no need for intermediate CA
certificates be vouched for by a root CA certificate.  In fact the
closer the CA certificate is to the leaf code signing certificate, the
better.  As much as possible we want to limit the CA keys being loaded
onto the machine keyring to those that are absolutely required.

thanks,

Mimi

> 
> > 1. "[PATCH v2 03/10] KEYS: X.509: Parse Basic
> >   a root_ca filed to a certificate to indicate the subject of the
> >   certificate is a CA. The name root_ca implies it's also a root CA. But
> >   according to [1], both an intermediate and root CA will have
> >   root_ca=True. For example, the intermediate certificate of
> >   https://www.kernel.org/ has "Certificate Authority=Yes" in the basic
> >   constraints. Btw, a root CA certificate by definition is self-signed,
> >   so the following code in "[PATCH v2 05/10] KEYS: Introduce a CA
> >   endorsed flag" looks a bit strange to me,
> >    if (cert->kcs_set && cert->self_signed && cert->root_ca)
> >        prep->payload_flags |= KEY_ALLOC_PECA;
> > 
> > 2. Since an intermediate CA certificate also has root_ca=True,
> >   "[PATCH v2 07/10] KEYS: X.509: Flag Intermediate CA certs as
> >   endorsed" won't work as intended i.e. this following else branch
> >   will never be reached,
> >   else if (!cert->self_signed && !cert->root_ca)
> >           prep->payload_flags |= KEY_MAYBE_PECA;
> > 
> > 3. I see nowhere public_key->key_is_ca is set to true for an intermediate
> >   CA certificate after it gains the KEY_ALLOC_PECA flag. So it will fail
> >   restrict_link_by_ca even if the KEY_MAYBE_PECA flag is added.
> > 
> > [1] https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.9
> 
> Thanks for reviewing the series.
> 


