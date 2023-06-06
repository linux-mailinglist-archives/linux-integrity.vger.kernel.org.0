Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39F7244C9
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 15:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjFFNsU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 09:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbjFFNsT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 09:48:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7995810E9;
        Tue,  6 Jun 2023 06:48:15 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356DgXe6013539;
        Tue, 6 Jun 2023 13:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=AHT+Ybg9/fl/7/tz6S1ei6dQZWzC6NTRq9JOTSx1ssQ=;
 b=SP1rJSv3V0SbcR6Zm8GKdwI2GUhF0nofkzPRFvtvQnffhzUvF/sszeqFW+Msf0DjwQsW
 sL2But2wRG2LeCtHDLII+4bKyR1Qxo3RN3N2wyBg50+Lq6QrwCO7PVwC0FVPIITMMQzY
 CfysJtMNGFHxzkBj3Gwc5oOTAonWWSYDqlHJ9a4/CnrCvrGTEwWgVnFGrV4Dn0YQ+YIO
 mBKulY8S2vLdrYVDYpRdvwOkkZ2TB7XWctd50Dtf1/4I/WdOhP3gP7BdhC08Elhrn/xL
 uppMCXCiUuedflCDDmOwkFYsNx8e+eNqGS6tJRKt/PFuPz9Hjo3uzKbfGAHZIRBBuhZ7 aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r25wt850p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 13:47:46 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 356Dh8f6016320;
        Tue, 6 Jun 2023 13:47:46 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r25wt8500-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 13:47:45 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 356DZSZA026530;
        Tue, 6 Jun 2023 13:47:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3qyxfs6yca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 13:47:44 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 356Dlh5g65732910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Jun 2023 13:47:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E4CB58063;
        Tue,  6 Jun 2023 13:47:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB8325803F;
        Tue,  6 Jun 2023 13:47:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.156.200])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  6 Jun 2023 13:47:42 +0000 (GMT)
Message-ID: <2592f1111059c175c3414cf80f3685bc6105ffa6.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] evm: Fix build warnings
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 06 Jun 2023 09:47:42 -0400
In-Reply-To: <20230606074113.2120632-1-roberto.sassu@huaweicloud.com>
References: <20230606074113.2120632-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oe9-NcpB1keSb98RVh2xj7N1oQDonZzy
X-Proofpoint-ORIG-GUID: J4idjPa3Dgxso7issXgUto3v8Vw4eFkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_08,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=932
 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-06-06 at 09:41 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Fix build warnings (function parameters description) for
> evm_read_protected_xattrs(), evm_set_key() and evm_verifyxattr().
> 
> Fixes: 7626676320f3 ("evm: provide a function to set the EVM key from the kernel")
> Fixes: 8314b6732ae4 ("ima: Define new template fields xattrnames, xattrlengths and xattrvalues")
> Fixes: 2960e6cb5f7c ("evm: additional parameter to pass integrity cache entry 'iint'")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks, Roberto.  This patch and 2/2 are now queued in next-integrity.

-- 
Mimi

