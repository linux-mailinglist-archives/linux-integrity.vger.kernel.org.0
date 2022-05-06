Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBD551D67F
	for <lists+linux-integrity@lfdr.de>; Fri,  6 May 2022 13:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345432AbiEFLU4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 May 2022 07:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244042AbiEFLUz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 May 2022 07:20:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD315DA31;
        Fri,  6 May 2022 04:17:07 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246AvTPO020974;
        Fri, 6 May 2022 11:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+EpF3VzKu+KmK6UkqQNJPa9WTJ1aH25dO2+qeNTHboQ=;
 b=Z61I6egSQjjOVGXVUh8Ht+HSE4Y9pvtLIRiVEhs51i1W3npA7PYozxfarQh0HDYtjz3I
 KH2JLewNLR3fIblyZixmiz0N9KAWMSG2ruxBa7x2zYFB/GpbMsDOpL+3yqggl3i2c6aL
 FiCPjFAEzTRgi4CKpYDBMpIOvlBQ7AxvdCIbr7lMnNW8sf57ei7BIEAhFWAWYB21PHxX
 OVnxC+ft9/0OkkJxf8En6R0i5ThjzWQ3GvRccPYWqwk6MJNYUetBaEzwYmKICU3y9OmL
 fP6eGi0h96/hGcIwKjxPYuQHky0uqseCD1Lc6FWmtCCgUbsb3bv+87caDh99pz/0FY39 Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw2cnrcc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 11:16:53 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 246AwNGi027547;
        Fri, 6 May 2022 11:16:52 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw2cnrcbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 11:16:52 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 246BDOu1002025;
        Fri, 6 May 2022 11:16:51 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3ftp7fwcs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 11:16:50 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 246BGmmu58392934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 May 2022 11:16:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BD6F4C046;
        Fri,  6 May 2022 11:16:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34F014C040;
        Fri,  6 May 2022 11:16:47 +0000 (GMT)
Received: from sig-9-65-81-120.ibm.com (unknown [9.65.81.120])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 May 2022 11:16:47 +0000 (GMT)
Message-ID: <c6df072a55a29f670357e2dda384ec7c9ef332c9.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] ima: Append line feed to
 ima/binary_runtime_measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Wang Weiyang <wangweiyang2@huawei.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Date:   Fri, 06 May 2022 07:16:46 -0400
In-Reply-To: <20220505132301.124832-4-wangweiyang2@huawei.com>
References: <20220505132301.124832-1-wangweiyang2@huawei.com>
         <20220505132301.124832-4-wangweiyang2@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4ioqBiyCyuIaBzkjGTnGwLoiVESWLZuh
X-Proofpoint-GUID: wk7lAduHv0EDXUwkV4L7URFEcIeGahX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_03,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=904 clxscore=1011
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-05-05 at 21:23 +0800, Wang Weiyang wrote:
> There is no LF in binary_runtime_measurements output. It is little weird,
> so append LF to it.
> 
> Example:
> 
> / # cat /sys/kernel/security/ima/binary_runtime_measurements
> ...imaboot_aggregate/ #

Why would you cat a binary file?!.  Doesn't make sense.

Mimi

> 
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>

