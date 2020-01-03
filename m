Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04ED12FCFC
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 20:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgACTZt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 14:25:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728550AbgACTZt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 14:25:49 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 003JLmOU058960
        for <linux-integrity@vger.kernel.org>; Fri, 3 Jan 2020 14:25:48 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xa2cdfkgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jan 2020 14:25:48 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 003JOur3020703
        for <linux-integrity@vger.kernel.org>; Fri, 3 Jan 2020 19:25:47 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 2x5xp6u85a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jan 2020 19:25:47 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 003JPiXL63046044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jan 2020 19:25:44 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8907BE051;
        Fri,  3 Jan 2020 19:25:44 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 572B4BE056;
        Fri,  3 Jan 2020 19:25:44 +0000 (GMT)
Received: from [9.2.202.58] (unknown [9.2.202.58])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jan 2020 19:25:44 +0000 (GMT)
Subject: Spec needed for ima-buf template - missing hash algorithm
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
 <1577996725.5874.114.camel@linux.ibm.com>
 <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
 <1578007322.5874.128.camel@linux.ibm.com>
 <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
 <181344e2-d809-87c6-399a-0201626130f1@linux.ibm.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <22cb85dc-0608-5000-9c9e-777f7314d98e@linux.ibm.com>
Date:   Fri, 3 Jan 2020 14:25:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <181344e2-d809-87c6-399a-0201626130f1@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-03_05:2020-01-02,2020-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxlogscore=766 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001030176
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Another question about the ima-buf template.  I discovered a log where 
the filename is blacklisted-hash.  It appears to be followed by 32-bytes 
that could be a hash.

Normally, hashes have an ASCII algorithm, a : and nul terminated string. 
  The one in my log omits the algorithm.  There are just 32 bytes.

1 - Is this a malformed log?

2 - Is the algorithm picked up from the d-ng field?

3 - If (2), what happens if there is a custom template like 'n-ng|buf' 
and there is no d-ng to pick up the hash algorithm from?
