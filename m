Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A12765B337
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Jan 2023 15:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjABOKS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Jan 2023 09:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjABOKR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Jan 2023 09:10:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2671B3A
        for <linux-integrity@vger.kernel.org>; Mon,  2 Jan 2023 06:10:16 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302DT8ok025422;
        Mon, 2 Jan 2023 14:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=2/yTpfTW5KIGUBAzOspgU4VScNeUG7paIE0eFQUXgWs=;
 b=MpF4j0KYUaTQ2xHpPQ1o9sHjw6vzWVH6AkA4h59F0G8hfqRm1cC5sUwAeOc/EZ/8EHeI
 rl67Gh6Jp/DTWDr+97u08GjAwe9q3bWFlCrzay8/vxImtG5fDeUCFUUUH8wrjfoP+goF
 DWS0j23yfjxnzCZJyJqyKvtN2GHdqGPzByDQIZFWPqHLqOdfUAxkJTe6VR7HYgaxmG2B
 Q0BfZkuMgYq7kbgKX5fCdcTrfhrOQXcmACZADjN0cB8t7n9XFaY//5C8RKPcfkNAwtdF
 ikJgCLv/78LW1oIeKKZ8nfo65F1vB/kAAHea+UvGHlpUeWyQ0cCbs+Bn4+C7T/51MKSB Yw== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mv06qgqs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 14:10:13 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 302CqE5c019375;
        Mon, 2 Jan 2023 14:10:12 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3mtcq7cm8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 14:10:12 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 302EABEr46006712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 14:10:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE5EE5805B;
        Mon,  2 Jan 2023 14:10:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CA965804B;
        Mon,  2 Jan 2023 14:10:11 +0000 (GMT)
Received: from sig-9-65-247-207.ibm.com (unknown [9.65.247.207])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jan 2023 14:10:11 +0000 (GMT)
Message-ID: <f4359a91a31b9b46f5cb7eb0e96c45c0c46ac282.camel@linux.ibm.com>
Subject: Re: [PATCH] libimaevm: do not crash if the certificate cannot be
 read
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Alberto Mardegan <photo@mardy.it>, linux-integrity@vger.kernel.org
Date:   Mon, 02 Jan 2023 09:10:10 -0500
In-Reply-To: <20221220120741.150456-1-a.mardegan@omp.ru>
References: <20221220120741.150456-1-a.mardegan@omp.ru>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JG_LEsib5eXTwUYaMkEmk80uGaV9_sBF
X-Proofpoint-ORIG-GUID: JG_LEsib5eXTwUYaMkEmk80uGaV9_sBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_08,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=659 priorityscore=1501 mlxscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-12-20 at 15:07 +0300, Alberto Mardegan wrote:
> This code path can be triggered if someone inadvertedly swaps the key
> with the certificate in the evmctl command line. Our `x` variable would
> be NULL, and we need to abort further processing of the certificate.
> 
> Signed-off-by: Alberto Mardegan <a.mardegan@omp.ru>

Hi Alberto, any chance you could fix the email address mismatch?

thanks,

Mimi

