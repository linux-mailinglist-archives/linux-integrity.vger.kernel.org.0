Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2775DDA01
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Oct 2019 20:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfJSSNP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 19 Oct 2019 14:13:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbfJSSNP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 19 Oct 2019 14:13:15 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9JI6cOK055582;
        Sat, 19 Oct 2019 14:13:13 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vqx4qv6kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Oct 2019 14:13:13 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9JI9w0k019336;
        Sat, 19 Oct 2019 18:13:12 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 2vqt46mqce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Oct 2019 18:13:12 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9JIDBVl65274362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 18:13:11 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECD13136051;
        Sat, 19 Oct 2019 18:13:10 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B154136055;
        Sat, 19 Oct 2019 18:13:10 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.146.216])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 19 Oct 2019 18:13:09 +0000 (GMT)
Subject: Re: [PATCH v0 1/1] ima: Refactor process_buffer_measurement() to make
 it generic
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, prsriva@linux.microsoft.com
References: <20191015220524.20659-1-nramas@linux.microsoft.com>
 <20191015220524.20659-2-nramas@linux.microsoft.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <585c2297-74c6-ea20-5c45-c81835ba1cb9@linux.vnet.ibm.com>
Date:   Sat, 19 Oct 2019 14:13:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191015220524.20659-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=732 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910190171
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,


On 10/15/2019 06:05 PM, Lakshmi Ramasubramanian wrote:
> This patch makes the function process_buffer_measurement() generic so that
> it can be used to measure more than just the KEXEC_CMDLINE. This function
> will also be used for measuring keys, blacklisted binaries, etc.

I have just now posted the new version with the change so that we do not 
duplicate the code and it handles both the requirements.

Thanks & Regards,
     - Nayna

