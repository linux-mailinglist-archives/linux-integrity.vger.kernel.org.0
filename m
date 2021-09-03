Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7640000C
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Sep 2021 14:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbhICM43 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Sep 2021 08:56:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235211AbhICM42 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Sep 2021 08:56:28 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183CtPSL141068
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 08:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+IyGGTO65iyvytQJUmaX5fNm5YYLOwd7g7iz0n1PN2c=;
 b=lmGK9bw2WbDvTfcVwVMB39wqL/17N0mCdI7mVFd/c5e+VPHxqHga8AyqYUbmBCwHMGv/
 XbKv/YpG31vMnWp8oS3oYJfsVVEbh6kUZyXQaAYifssxvo3Zc+dNkq0IMb9rd+q/34mE
 VIPD/FJP8kBJH0EeYuWuGnZkybmZ9M5OXdW6HSFpBLEX4sBVTPvfRVffbUxleTWefjiD
 CB0gKQR/4sE7I1kI59LLyfPwH6e/ND8dYm9214mVdv25WA4wtcdgBWtWzdPMtw7IImy7
 VnRtEmo375ir+IK9RQ8zKhh32wopkqrBtDp9fm1unOhTNgrUSo5BmR8PTIHNuFsC+y6H Cw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aukrwggtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 08:55:28 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 183CmEPN000583
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 12:55:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3au6q7gf6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 12:55:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 183CtM3g43843938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 12:55:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40C1E52051;
        Fri,  3 Sep 2021 12:55:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.38.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6AA4752073;
        Fri,  3 Sep 2021 12:55:21 +0000 (GMT)
Message-ID: <9508d3dd5fea7ef1aa8561935bef05a25170e6f8.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/8] evmctl: Move code setting up engine to own
 funtion
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 03 Sep 2021 08:55:20 -0400
In-Reply-To: <20210810134557.2444863-4-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
         <20210810134557.2444863-4-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WjGSVk9JuLsla9lbPCkk_J8xMjDuVx6Z
X-Proofpoint-GUID: WjGSVk9JuLsla9lbPCkk_J8xMjDuVx6Z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_03:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=987
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030077
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-08-10 at 09:45 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>

Missing patch description.

For example, the subject line could be "evmctl: define a function to
setup the openssl engine".  Provide the motivation before saying, "move
the existing code setting up engine to own function."

thanks,

Mimi

