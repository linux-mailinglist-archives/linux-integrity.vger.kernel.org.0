Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1904E7248B2
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 18:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbjFFQOI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 12:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238535AbjFFQNz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 12:13:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E31BDA;
        Tue,  6 Jun 2023 09:13:30 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356FtA0E004822;
        Tue, 6 Jun 2023 16:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ItTEMDQaLcG8/C03VwCVa3e1JHe3WJRdtIdGH5rd+F8=;
 b=eGf8adxbr6UCVMm7zCPBiRK9vsI0Qzm1q4jCNzFmWl1piRgrJpQBR2p2hkSW40OwE1mY
 paA7k3PDY37dFfymjkUhYtKSgrQoznTAn8Tfy19kzOLN/Laf8wKvY9twb6a+ajRN5zkU
 oaMcFxS7qr01zG3e2S0D0/FAoZ+UOZJXYc7B3ff/1U0VHTYoPxJ5H2md5ZSegSonrGt2
 0+Czx2gttSgNSbTBKd1s8oNKQW65WrPTlwnjBTW0ykkRlHFQbmVut2ziJ+pPKO0XSSiJ
 BZ/OLvFULahMYMZ8eeHGqqu7XcpLLspUg/8/dDVnEr7q2XLYc6Vh/GP9/moR3kX3nJSc 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r27v38mx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:12:45 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 356G5dxD008570;
        Tue, 6 Jun 2023 16:11:17 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r27v38hu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:11:17 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 356DZ76H026551;
        Tue, 6 Jun 2023 16:10:00 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3qyxfs7mcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:10:00 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 356G9xAH25166478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Jun 2023 16:09:59 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46FFA58056;
        Tue,  6 Jun 2023 16:09:59 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EEDC5803F;
        Tue,  6 Jun 2023 16:09:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.156.200])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  6 Jun 2023 16:09:58 +0000 (GMT)
Message-ID: <276a89395a11bf2c38fc2b24bdfd8a62f1430199.camel@linux.ibm.com>
Subject: Re: [PATCH v11 0/4] evm: Do HMAC of multiple per LSM xattrs for new
 inodes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 06 Jun 2023 12:09:57 -0400
In-Reply-To: <20230603191518.1397490-1-roberto.sassu@huaweicloud.com>
References: <20230603191518.1397490-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0TCbPqgVKGNR4UXcvRUcBgLYu5_WdkeO
X-Proofpoint-GUID: _VGTxzAZ99ehSLP5eYDeMRxXp3w8K7oP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_11,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=624
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060137
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

Based on which git repo/branch does this patch set apply?  In the
future please include the "--base" option.

-- 
thanks,

Mimi

