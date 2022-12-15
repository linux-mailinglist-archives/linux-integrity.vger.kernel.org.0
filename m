Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8016164D972
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Dec 2022 11:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiLOKWD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Dec 2022 05:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiLOKV4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Dec 2022 05:21:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438241D66E;
        Thu, 15 Dec 2022 02:21:55 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFABrlx031884;
        Thu, 15 Dec 2022 10:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=25J3tmS0CQRm5M+aL1a3pu4Teu7wCVJydV//fYAkxg8=;
 b=rsOVNm/jSLiVMl3DP/ED0AGqsdgedbeFl+jDlhjn5V4wNDtCfpERDvE5yileznuC4e5F
 9+/QEL0PmwJb4FA4iQTrFBisMAn9RIl3lXIIZWl7WTDD1717KkOJwAuhENmkVCIKIpcj
 26kxXG0VPgOvd9YhxY8UEMX+E3Cn2BKFF/voXYpnSBScEdUxHjElPYdoxws2CKmLpyt7
 bEjpQzQDk5PQt8nbG6ptd2HLR/QWP7XmGiqhWZMCUeU/CK3BiPiGyy/o/sSr6qJgXYam
 9vMKe0H/P+qssw7fkNsjVKRWrCIbtX4Zw4UONgDVRy3rx2UajpoHy3q2kNcBVQLiVTeA /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mg1m3g6sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 10:21:23 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BFADSjI005138;
        Thu, 15 Dec 2022 10:21:22 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mg1m3g6ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 10:21:22 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF8E25e011769;
        Thu, 15 Dec 2022 10:21:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3meyyhw129-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 10:21:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BFALJVf5701934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 10:21:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81FE15805F;
        Thu, 15 Dec 2022 10:21:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 347D05805D;
        Thu, 15 Dec 2022 10:21:18 +0000 (GMT)
Received: from sig-9-65-242-118.ibm.com (unknown [9.65.242.118])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Dec 2022 10:21:18 +0000 (GMT)
Message-ID: <7d61852678d1652030ce9c7c2f906217c5c4ce06.camel@linux.ibm.com>
Subject: Re: [PATCH v3 07/10] KEYS: X.509: Flag Intermediate CA certs as
 endorsed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 15 Dec 2022 05:21:17 -0500
In-Reply-To: <20221214003401.4086781-8-eric.snowberg@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
         <20221214003401.4086781-8-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g3aTJeon1Lgo5P8BsoQre75BFY68m_fg
X-Proofpoint-ORIG-GUID: NbJVGw742pMa7IzUmlMZz_8rmmLyZQ9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_03,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On Tue, 2022-12-13 at 19:33 -0500, Eric Snowberg wrote:
> Currently X.509 intermediate certs with the CA flag set to false do not
> have the endorsed CA (KEY_FLAG_ECA) set. Allow these intermediate certs to
> be added.  Requirements for an intermediate include: Usage extension
> defined as keyCertSign, Basic Constrains for CA is false, and the
> intermediate cert is signed by a current endorsed CA.

Intermediary keys should have the CA flag enabled as well.   Why is
this needed?    At least for the new Kconfig, please keep it simple as
to which certificates may be added to the machine keyring.

thanks,

Mimi

