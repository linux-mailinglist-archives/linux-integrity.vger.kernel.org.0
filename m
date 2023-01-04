Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FE065E019
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 23:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbjADWis (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Jan 2023 17:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjADWiq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jan 2023 17:38:46 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3FC1EC79;
        Wed,  4 Jan 2023 14:38:45 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304ME1CI018620;
        Wed, 4 Jan 2023 22:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dnzle0EcHMmwGRtnVfx0mWs2UVkVr780qRGnF49Zxbw=;
 b=PqUzd7tArfL9HGT34lPsW6zlrVMMIK535/wJOQoVQZ0gW1WTH0F34zg8wHIkJ0T+78zI
 9SyDP/o+2ZSjXkXAwWoQm4LWk8v8NBwrycMasue3XpHOqx9HtkSfcE9Qv2iEj09hOeK5
 ZIG+dkVdQSWcxT0MMKKcPZ/lD4VaGFMdEskERUchWy1oyuzogVTUrXMvvyKx+0sLfvK5
 Lyozi++13HBffdqTXnsN4UG1Az1KEBfTh+bBtkC1a+5gwyTw/TK8Stih7oG/fuFEq5r/
 LZZsu2j9NXhehyg7bXZRWmK7dT2D7I3TZuQwtkvszafXOvb6uyHsp8HXBpLCWIz4ENGV Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mwj2hgkfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 22:38:16 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304MZFBa004552;
        Wed, 4 Jan 2023 22:38:15 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mwj2hgker-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 22:38:15 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 304MW0JQ019440;
        Wed, 4 Jan 2023 22:38:15 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3mtcq7tgas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 22:38:15 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 304McERA2622200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jan 2023 22:38:14 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5B3A58066;
        Wed,  4 Jan 2023 22:38:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B763A58062;
        Wed,  4 Jan 2023 22:38:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.185.16])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jan 2023 22:38:11 +0000 (GMT)
Message-ID: <1738bcddc690825f634bfe41ca1df778a1a50b0a.camel@linux.ibm.com>
Subject: Re: [PATCH v3 03/10] KEYS: X.509: Parse Basic Constraints for CA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
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
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        Coiby Xu <coxu@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Wed, 04 Jan 2023 17:38:07 -0500
In-Reply-To: <5F14DD59-7139-427E-A263-D5DED6EB57F8@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
         <20221214003401.4086781-4-eric.snowberg@oracle.com>
         <b0f29738b919e2705d770017f2f1eb0542c2fad4.camel@linux.ibm.com>
         <Y7VxDloaHyF8cX5j@kernel.org>
         <5F14DD59-7139-427E-A263-D5DED6EB57F8@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qxLcN76R_0JpWidhJf1J_gZEXtL92O2g
X-Proofpoint-GUID: shNbEMAaO2O3rlpd5WibO3G1L5cR6plP
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040183
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-01-04 at 20:14 +0000, Eric Snowberg wrote:
> 
> > On Jan 4, 2023, at 5:29 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > On Thu, Dec 15, 2022 at 06:10:04AM -0500, Mimi Zohar wrote:
> >>> diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
> >>> index a299c9c56f40..7c5c0ad1c22e 100644
> >>> --- a/crypto/asymmetric_keys/x509_parser.h
> >>> +++ b/crypto/asymmetric_keys/x509_parser.h
> >>> @@ -38,6 +38,7 @@ struct x509_certificate {
> >>> 	bool		self_signed;		/* T if self-signed (check unsupported_sig too) */
> >>> 	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
> >>> 	bool		blacklisted;
> >>> +	bool		root_ca;		/* T if basic constraints CA is set */
> >>> }; 
> >> 
> >> The variable "root_ca" should probably be renamed to just "ca", right?
> > 
> > Perhaps is_ca?
> 
> I am open to renaming this, but need an agreement on whether the “is_” should be used or not:
> 
> https://lore.kernel.org/lkml/b28ea211d88e968a5487b20477236e9b507755f4.camel@linux.ibm.com/

Examples of both functions and variables exist that are prefixed with
"is_".   One is a question; the other a statement.   Naming the
variable "is_ca" and using it like "if (cert->is_ca)" does make sense.

-- 
thanks,

Mimi

