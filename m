Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC934F9B1F
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Apr 2022 18:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiDHQ6B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Apr 2022 12:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbiDHQ5o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Apr 2022 12:57:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9051B131F7C;
        Fri,  8 Apr 2022 09:55:40 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238FWIKs023792;
        Fri, 8 Apr 2022 16:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=aSPw71N6YAus4Lw3a/KpDS8yxndXDFxZ+t1IHdY+Sj0=;
 b=Uhu5mebSQ5b4hz9zXKchMBiIQ1CFjvJeXj7tUVSdci+3FOELNm+KHeAHV7EAV8VEmKjq
 95Kjt96bCn5uqLhlrUNZKPMruHeOlT2Kq0T0f0P57mK2Gwq6GBZWavWxRWpA/9dPahps
 SWi1UPV1W6aHTKwYxUHKqENBIuVI1n6oIc5hJ6rK+li2TTv1UqtXvKVEui8rsrHQGULu
 l/13p+7MN1nkBNUoHPUNl3eqguWPhFCXe7FsZOpgTuzV8ITyqASwWVhVLneFsMr9fixH
 nbK4MtxdPrzA/rqEkbeHY/q0iGa1//QNW/fFnle2QjhgPC0OgqEo8oGgG7epwH/iuS4b Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3faed35hpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 16:55:18 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 238GAHFE030990;
        Fri, 8 Apr 2022 16:55:17 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3faed35hnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 16:55:17 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 238GrLlL022218;
        Fri, 8 Apr 2022 16:55:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3f6e48t1me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 16:55:14 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 238GtBiw54788360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Apr 2022 16:55:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD8765204F;
        Fri,  8 Apr 2022 16:55:11 +0000 (GMT)
Received: from sig-9-65-90-167.ibm.com (unknown [9.65.90.167])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1C5FB5204E;
        Fri,  8 Apr 2022 16:55:09 +0000 (GMT)
Message-ID: <b8965652274b49ba7c6f67cad6d42965cf984b42.camel@linux.ibm.com>
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
Date:   Fri, 08 Apr 2022 12:55:08 -0400
In-Reply-To: <EF1544D5-54E8-4D47-82F8-F9337CA7AEA0@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
         <20220406015337.4000739-5-eric.snowberg@oracle.com>
         <4fbef0889d6f286c7fcd317db099b4857e1b2fa3.camel@linux.ibm.com>
         <EF1544D5-54E8-4D47-82F8-F9337CA7AEA0@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DE3iTPmeYYmrJJX-V895r7t5mc0mVyNW
X-Proofpoint-ORIG-GUID: d-YckLjF4CLTuYTIwa4qO2vetHBeylLH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_05,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-04-08 at 15:27 +0000, Eric Snowberg wrote:
> 
> > On Apr 8, 2022, at 8:40 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Tue, 2022-04-05 at 21:53 -0400, Eric Snowberg wrote:
> >> 
> >> The first type of key to use this is X.509.  When a X.509 certificate
> >> is self signed, has the kernCertSign Key Usage set and contains the
> >> CA bit set this new flag is set.
> >> 
> >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> >> 
> >> diff --git a/include/linux/key.h b/include/linux/key.h
> >> index 7febc4881363..97f6a1f86a27 100644
> >> --- a/include/linux/key.h
> >> +++ b/include/linux/key.h
> >> @@ -230,6 +230,7 @@ struct key {
> >> #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
> >> #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
> >> #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
> >> +#define KEY_FLAG_BUILTIN_ROT	10	/* set if key is a builtin Root of Trust key */
> >> 
> >> 	/* the key type and key description string
> >> 	 * - the desc is used to match a key against search criteria
> >> @@ -290,6 +291,7 @@ extern struct key *key_alloc(struct key_type *type,
> >> #define KEY_ALLOC_BYPASS_RESTRICTION	0x0008	/* Override the check on restricted keyrings */
> >> #define KEY_ALLOC_UID_KEYRING		0x0010	/* allocating a user or user session keyring */
> >> #define KEY_ALLOC_SET_KEEP		0x0020	/* Set the KEEP flag on the key/keyring */
> >> +#define KEY_ALLOC_BUILT_IN_ROT		0x0040  /* Add builtin root of trust key */
> > 
> > Since the concept of root of trust is not generic, but limited to
> > specific keyrings, the root CA certificate signing keys on the
> > "machine" keyring need to be identified.  Similar to the
> > KEY_ALLOC_BUILT_IN/KEY_FLAG_BUILTIN, new flags
> > KEY_ALLOC_MACHINE/KEY_FLAG_MACHINE should be defined instead.
> 
> I’m open to renaming these, however this name change seems confusing to me.  
> This flag gets set when the X.509 certificate contains the three CA requirements 
> identified above.  The remaining keys in the machine keyring can be used for 
> anything else.

Renaming the flag to KEY_ALLOC_MACHINE/KEY_FLAG_MACHINE differentiates
between the "builtin" keys from the "machine" keys.  The trust models
are very different.

> Plus this flag can be set for keys loaded into the secondary trusted 
> keyring (6th patch in the series).  When an intermediate CA gets loaded into the 
> secondary, the flag is set as well.

Please include a full explanation with the motivation in the patch
description as to why support for intermediary CAs is required for the
"end-user" use case.

thanks,

Mimi

