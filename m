Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A8705C46
	for <lists+linux-integrity@lfdr.de>; Wed, 17 May 2023 03:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjEQBTQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 May 2023 21:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjEQBTL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 May 2023 21:19:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED3946B8;
        Tue, 16 May 2023 18:18:57 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H1Brql017084;
        Wed, 17 May 2023 01:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=vIE2W4w77++8cdSRWw17/uGI+S/ioy1NWgJSZqgWq0k=;
 b=Say9xVllENx5owHUYNktS930wTKTj8lYf4apWDiNJdmpkFN1fzA4xTIhwLDuA4L5zsrJ
 34n+lbO/P2Lmr4FjE3CSCZdrofFeXXRTgioGz0U31BpRh4j7QfSA6HxxtJHPjE0h1Sz6
 diqtBA7PNZlLOjYUt07LJF6fcl3T1cJj4Hzxusz8QC2ccj1toR2v+26xc2GOHeaFRcM5
 sC0o7moIQWWxPEHc04l39r7n/5Zqwdc8+LYNW5gtJkkzkJ7LSeG5dsV5Kz7lwoSYhjsz
 NmyMY+IZJtnGzfD6VzClwT0I/cRc4J/Kd0Y9GDj1Ql99a2GJ1rRRFPeylz+stamOoldo zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmn22r4hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 01:18:36 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34H1EoQV024877;
        Wed, 17 May 2023 01:18:35 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmn22r4h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 01:18:35 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34H0JDLU025221;
        Wed, 17 May 2023 01:18:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3qj265yy73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 01:18:34 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34H1IXeB31392250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:18:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE9915805D;
        Wed, 17 May 2023 01:18:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C63755805C;
        Wed, 17 May 2023 01:18:30 +0000 (GMT)
Received: from sig-9-77-133-203.ibm.com (unknown [9.77.133.203])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 17 May 2023 01:18:30 +0000 (GMT)
Message-ID: <e8c470bcf50282680300cd04a6aba0d0dbdef035.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] integrity: Remove EXPERIMENTAL from Kconfig
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, jlee@suse.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 16 May 2023 21:18:30 -0400
In-Reply-To: <20230508220708.2888510-4-eric.snowberg@oracle.com>
References: <20230508220708.2888510-1-eric.snowberg@oracle.com>
         <20230508220708.2888510-4-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LwaftEa0i45zaMhbeCaoP0_meuq_ur0_
X-Proofpoint-GUID: YOAFi2lIcuThCqoQJupaJ-ottlMst4CO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170006
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-05-08 at 18:07 -0400, Eric Snowberg wrote:
> Remove the EXPERIMENTAL from the
> IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY Kconfig
> now that digitalSignature usage enforcement is set.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

