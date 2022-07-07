Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2B056ADD7
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 23:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiGGVkI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 17:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbiGGVkG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 17:40:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DDF20BCA
        for <linux-integrity@vger.kernel.org>; Thu,  7 Jul 2022 14:40:05 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267LBnYI021312;
        Thu, 7 Jul 2022 21:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=TXArq0fnsklufQYgFBckd0IvprgJ14bXaXmbp/Hnhg4=;
 b=CMgLOzxaHNKE1NFSBTDWUPEGwwOqOx3RoB0ruXSnHneqKQ7JiWFwmPuYQjosOP2balck
 FtR5xTLiKJ0Ryu3msG1BrpFodOlUqjQdgf/aUwe/fUtce6quOg0pN+SrqYg8fC6EOwkG
 uY/nKEy0iIgERHVZZ2Uhf3AA0rveseH0hiSWdkR3S+Hq7ucTRARJABMUKv8RMNjJV6T1
 t+w1VePg4ddriCOylUtb8C7H5W8bpbWLIraMz9odILejhq1ELbIPFWXRiy0zsWXSoIPa
 sGwFT01v4nJyrlyGPod13XsTNB0Mtmo54HjZNa1i4SbFaBhUybFww/1gY0wPuEECtlZJ kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h676j8m2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 21:39:57 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267Lcj3S029873;
        Thu, 7 Jul 2022 21:39:56 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h676j8m26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 21:39:56 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267LaxfD012650;
        Thu, 7 Jul 2022 21:39:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3h4v8qj92q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 21:39:54 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Le1tO33358146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 21:40:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E840BA404D;
        Thu,  7 Jul 2022 21:39:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF325A4040;
        Thu,  7 Jul 2022 21:39:50 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.77.198])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 21:39:50 +0000 (GMT)
Message-ID: <9ce642dc107ca27528fe2d5ff0aa0a7a01af607a.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: Fix a potential integer overflow in
 ima_appraise_measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     luhuaxin1@huawei.com, linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com
Date:   Thu, 07 Jul 2022 17:39:49 -0400
In-Reply-To: <20220705051417.2114-1-luhuaxin1@huawei.com>
References: <20220705051417.2114-1-luhuaxin1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dRmBp4Ay2XCfruBgN7PCiUgz_7gd--7G
X-Proofpoint-GUID: ub1DUVc-T95ZkrHwHd6BzevEZgkcPn-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_17,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 mlxlogscore=969 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1011
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-07-05 at 13:14 +0800, luhuaxin1@huawei.com wrote:
> From: Huaxin Lu <luhuaxin1@huawei.com>
> 
> When the ima-modsig is enabled, the rc passed to evm_verifyxattr() may be
> negative, which may cause the integer overflow problem.
> 
> Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>

Thanks, Huaxin.  This patch is now queued in next/next-testing.

Mimi

