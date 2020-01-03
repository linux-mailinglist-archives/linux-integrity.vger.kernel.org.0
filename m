Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E72E12FCC3
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 19:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgACS5G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 13:57:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728372AbgACS5F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 13:57:05 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 003IqdqM126183
        for <linux-integrity@vger.kernel.org>; Fri, 3 Jan 2020 13:57:04 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xa68erqwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jan 2020 13:57:04 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 003IpTd5015602
        for <linux-integrity@vger.kernel.org>; Fri, 3 Jan 2020 18:57:03 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 2x5xp6u1qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jan 2020 18:57:03 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 003Iv0Bs54264118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jan 2020 18:57:01 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBF8BBE04F;
        Fri,  3 Jan 2020 18:57:00 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BFB4BE053;
        Fri,  3 Jan 2020 18:57:00 +0000 (GMT)
Received: from [9.2.202.58] (unknown [9.2.202.58])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jan 2020 18:57:00 +0000 (GMT)
Subject: Spec needed for ima-buf template
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
 <1577996725.5874.114.camel@linux.ibm.com>
 <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
 <1578007322.5874.128.camel@linux.ibm.com>
 <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <181344e2-d809-87c6-399a-0201626130f1@linux.ibm.com>
Date:   Fri, 3 Jan 2020 13:57:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-03_05:2020-01-02,2020-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=954 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001030171
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In the ima-buf template, I sense that the n-ng file names are not 
actually file names, but (sort of) ASCII enums.  Is that right?

1 - I've identified a few that mean the 'buf' contents are DER encoded 
X509 certificates.  Are there others in this group?

.builtin_trusted_keys
.ima

2 - There is evidently a 'file name' that indicates that the contents 
are the boot command line.  Would it be '/proc/cmdline' or something else?

Could the name vary with the kernel version or distro?

What would be a maximum length for this buf beyond which the verifier 
should report an error?

3 - What other file names could a verifier expect?

4 - What happens if there is a 'buf' but not an 'n-ng'?  For
example, the custom template "d-ng | buf".  Or if there is an n-ng but 
the file name length is zero?

Is this an error?  If not, how would the contents of buf be interpreted 
without a file name?

5 - Are the file names for this template fixed today, or could there be 
more added in the future?  If more could be added, is there the concept 
of 'critical' names that a verifier must understand or reject and 
non-critical that the verifier could safely ignore?


