Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241AA1EFBBF
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2020 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgFEOqf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 10:46:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbgFEOqf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 10:46:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 055EW5tV073719
        for <linux-integrity@vger.kernel.org>; Fri, 5 Jun 2020 10:46:34 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31fk7dsg8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 05 Jun 2020 10:46:34 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 055Eiq1S023972
        for <linux-integrity@vger.kernel.org>; Fri, 5 Jun 2020 14:46:33 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 31bf4ax85v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 05 Jun 2020 14:46:33 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 055EjW0Y46006708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Fri, 5 Jun 2020 14:45:32 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53DD2112064
        for <linux-integrity@vger.kernel.org>; Fri,  5 Jun 2020 14:45:32 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B868112062
        for <linux-integrity@vger.kernel.org>; Fri,  5 Jun 2020 14:45:32 +0000 (GMT)
Received: from [9.80.238.131] (unknown [9.80.238.131])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Fri,  5 Jun 2020 14:45:32 +0000 (GMT)
To:     linux-integrity@vger.kernel.org
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: TPM resource manager separation
Message-ID: <6693966c-132e-c35a-af08-7513cab33fc3@linux.ibm.com>
Date:   Fri, 5 Jun 2020 10:45:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_04:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=1 mlxlogscore=686 bulkscore=0 spamscore=0 priorityscore=1501
 cotscore=-2147483648 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050107
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Low level question:

Does the RM keep track of which handle / object belongs to which process?

E.g., process A loads a key and gets handle 80ffffff.  Process B then 
tries to do an operation using handle 80ffffff.  Will the RM reject it?

High level question:

Does the RM have any design or capability documentation?  Is there a 
place to get answers other than this mailing list.
