Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18A66ED3D8
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Apr 2023 19:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjDXRph (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Apr 2023 13:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXRpg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Apr 2023 13:45:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7A2E9
        for <linux-integrity@vger.kernel.org>; Mon, 24 Apr 2023 10:45:34 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OHOUJF032256;
        Mon, 24 Apr 2023 17:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=J22ncXg5bI3SXiW3gx3ISaNDlvx5JyrIBN64vCWzjkU=;
 b=h3lc88zV6k1y9cdpzezo4mKP4sveyBTOxA1dznXCIp5R3Jkm0fxLDAVNI4MAkaEITOdH
 va/DJfKBmm0MXzh0wPzFxVxcJNPj/4Zb6/CKo+RFwJjKzeRgecFRkcPZwfY5/lu5XhSR
 uSTcLNFxSSifNzeo4K0zRX4oXZvzZQFT4WLlDVFyF0WgsFVTwC87OU+3qXFY8ujGCGoR
 zJZx2mMZbqoDWBcDGTGzAN81q37dlUqS/tFHgS+nGT+pE0/lME74LfPC1M7RHmZ6HbAE
 st7BYu3SJUJVxuEymIlwbWxn8gVDUgWGuoRCwHuo6azYiog0dadPwNwMwCajU8yWH8Gs fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q5x4w0k29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 17:45:15 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33OHRkaY011455;
        Mon, 24 Apr 2023 17:45:14 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q5x4w0k1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 17:45:14 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33OGAkS5008571;
        Mon, 24 Apr 2023 17:45:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3q4777yb8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 17:45:13 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33OHjChw4981414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 17:45:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E03E58059;
        Mon, 24 Apr 2023 17:45:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76E895805B;
        Mon, 24 Apr 2023 17:45:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.153.155])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 24 Apr 2023 17:45:11 +0000 (GMT)
Message-ID: <96946214b601f36bb97893939371508efb19fe64.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 1/2] Add --hmackey option for evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 24 Apr 2023 13:44:55 -0400
In-Reply-To: <20230324181149.44694-1-roberto.sassu@huaweicloud.com>
References: <20230324181149.44694-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4NDe-CCO2KofTPmzp2YbZimd0kMl85XQ
X-Proofpoint-GUID: FVc88T7WMfs35Dxazad8l7UnnMUdMEzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=908 priorityscore=1501 clxscore=1015
 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304240158
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-03-24 at 19:11 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add the --hmackey option, to specify an alternative path for the file
> containing the HMAC key. By default evmctl looks in
> /etc/keys/evm-key-plain.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Please document the change in the evmctl.c usage and the README.

Please note that when DEBUG is not enabled, "evmctl hmac" is not
defined.   Patch 2/2 assumes that "evmctl hmac" is configured.

-- 
thanks,

Mimi

