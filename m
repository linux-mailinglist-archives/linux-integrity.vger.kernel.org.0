Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7230F68F966
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 22:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjBHVDY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Feb 2023 16:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjBHVDX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Feb 2023 16:03:23 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD64249409;
        Wed,  8 Feb 2023 13:02:59 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318KpdSb013904;
        Wed, 8 Feb 2023 21:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=rvd1JA6+zz485exTtePCEeWJ5Uu5+iP6CvMXrmv4+Kw=;
 b=qjOR1rBygB3V++lpY/aEDBaZ8c4pAtaiOTHV/b+WW/89e0MpSfMCvXkwXvtI34AmggW+
 TauQdgdUVis/3aPpmvVNSBjlcpqFgSaIaQ7Me8zwzpkwpcikTmIIx1i71SQyhzc3PQNm
 wPy3KsjRAQ3wE9PMmWducFtFaeRuViQT2vcl1RuIJopz0YklK2pBxds9WF/Df2y+JKh0
 dGyw1BzTOrqKMxVDBQ9iIHAi6ThsLxfSuLqdHIdHpTQamGu8meJhI7g9vVKiVXYSqov2
 kWE+Gb1iyFzBaTUBXi5L6gzVDIoarDPtxN8uUKHGmz5sDnYvEqqwX2LYuJ+tKeQCR3xC NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmk5207r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 21:02:08 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 318KpoxO014226;
        Wed, 8 Feb 2023 21:02:07 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmk5207qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 21:02:07 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 318I3R2E017625;
        Wed, 8 Feb 2023 21:02:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3nhf07vvh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 21:02:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318L24LE58261904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 21:02:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CCDC58059;
        Wed,  8 Feb 2023 21:02:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAF8458043;
        Wed,  8 Feb 2023 21:02:01 +0000 (GMT)
Received: from sig-9-65-211-196.ibm.com (unknown [9.65.211.196])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 21:02:01 +0000 (GMT)
Message-ID: <9f3f7a0eaa55bf5f61309b9d46e3c69f8c655154.camel@linux.ibm.com>
Subject: Re: [PATCH v4 3/6] KEYS: X.509: Parse Basic Constraints for CA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, tadeusz.struk@intel.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 08 Feb 2023 16:01:56 -0500
In-Reply-To: <20230207025958.974056-4-eric.snowberg@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
         <20230207025958.974056-4-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Npt-d7LhF3Q8-fTGMpvCAT3ETFYZV5Xk
X-Proofpoint-ORIG-GUID: 4er8aJ4c7mUXtf9nq5KcorXDq7eWc_jS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080175
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-02-06 at 21:59 -0500, Eric Snowberg wrote:
> Parse the X.509 Basic Constraints.  The basic constraints extension
> identifies whether the subject of the certificate is a CA.
> 
> BasicConstraints ::= SEQUENCE {
>         cA                      BOOLEAN DEFAULT FALSE,
>         pathLenConstraint       INTEGER (0..MAX) OPTIONAL }
> 
> If the CA is true, store it in the public_key.  This will be used
> in a follow on patch that requires knowing if the public key is a CA.
> 
> Link: https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.9
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

