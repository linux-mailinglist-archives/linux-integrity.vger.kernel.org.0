Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4F756AEE3
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Jul 2022 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbiGGXPe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 19:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiGGXPd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 19:15:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6002127FD5;
        Thu,  7 Jul 2022 16:15:30 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267NCGVc006368;
        Thu, 7 Jul 2022 23:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KAXRanh8SZV9oVzDpI4U/Isuvm+o+aN26hXhRYySckc=;
 b=byDRGw8iGLugWdm91oA1f2TUyZKxoTu8mBeawYCkx15OsWk3gBNibN8mZh8ipVnPAEja
 0Hqu4ipKpaLORwkDqW4aNpPZ/cw5XtMfQbMbWohH78ITUF73UVuIoqI109g3e99qZW6L
 uqAkL0rZ0akGRCwG0DbiT/tvQ8NSs5w5ch2n9BoyvdQG20BGZGKmvI48k6VF4oB+dj+R
 m2QIr5mT9RgPDCX9TLQUIeyI6sgqlUkEY6xEjPWXtb62MunbzvmKB+W/ZiBFnN5jI8lG
 CS5l0fTzpR7OwBjIEoEblxoICx45rYMWjoLDDTwo2WodrFgGkuz4nsGhLzMqLnrBepSP nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h68xr821y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 23:15:22 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267NEajQ020952;
        Thu, 7 Jul 2022 23:15:22 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h68xr8216-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 23:15:22 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267N5uVw010938;
        Thu, 7 Jul 2022 23:15:19 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3h4usd35uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 23:15:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267NFHqj21299500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 23:15:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71CF1A4057;
        Thu,  7 Jul 2022 23:15:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97139A4051;
        Thu,  7 Jul 2022 23:15:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.77.198])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 23:15:15 +0000 (GMT)
Message-ID: <47fc2c7857600dd017cdede786b094d7b961dab6.camel@linux.ibm.com>
Subject: Re: [PATCH -next] evm: Use IS_ENABLED to initialize .enabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Jul 2022 19:15:14 -0400
In-Reply-To: <20220606101042.89638-1-xiujianfeng@huawei.com>
References: <20220606101042.89638-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: datqKVPqvBnsxJBdrgI9yc6ZZkyXQxzA
X-Proofpoint-ORIG-GUID: EbxYwlsqVjBRcvApq6B-xszh25UDEKjA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_17,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0 mlxlogscore=958
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-06-06 at 18:10 +0800, Xiu Jianfeng wrote:
> Use IS_ENABLED(CONFIG_XXX) instead of #ifdef/#endif statements to
> initialize .enabled, minor simplicity improvement.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Thanks, Xiu.   This patch is now queued in next-testing.

Mimi

