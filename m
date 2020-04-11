Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E87F1A53D1
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Apr 2020 23:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgDKVnw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Apr 2020 17:43:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726029AbgDKVnw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Apr 2020 17:43:52 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03BLX4Fe008984;
        Sat, 11 Apr 2020 17:43:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30b6ttftpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Apr 2020 17:43:43 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03BLaZ5M013776;
        Sat, 11 Apr 2020 17:43:43 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30b6ttftpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Apr 2020 17:43:43 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03BLfMVK007615;
        Sat, 11 Apr 2020 21:43:42 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 30b5h5xayg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Apr 2020 21:43:42 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03BLhfVn12452540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Apr 2020 21:43:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A71392805E;
        Sat, 11 Apr 2020 21:43:41 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF3EA28058;
        Sat, 11 Apr 2020 21:43:40 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.65.249.129])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 11 Apr 2020 21:43:40 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] support to read and tune appraise mode in runtime
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        zhang.jia@linux.alibaba.com
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, zhangliguang@linux.alibaba.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200409103440.47946-1-tianjia.zhang@linux.alibaba.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <1e160d08-788a-0c3b-0f9f-2077e55b286a@linux.vnet.ibm.com>
Date:   Sat, 11 Apr 2020 17:43:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409103440.47946-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-11_06:2020-04-11,2020-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxlogscore=983
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004110193
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/9/20 6:34 AM, Tianjia Zhang wrote:
> Support the read and write operations of ima_appraise by adding a
> securifyfs file 'appraise_mode'.
>
> In order to tune appraise mode in runtime, writing a PKCS#7 signature

I am curious to know why would you tune appraise mode in runtime ?

Thanks & Regards,

       - Nayna

