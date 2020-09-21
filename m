Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3577272B06
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Sep 2020 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgIUQIe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Sep 2020 12:08:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727392AbgIUQId (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Sep 2020 12:08:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08LG3TKp127734
        for <linux-integrity@vger.kernel.org>; Mon, 21 Sep 2020 12:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : cc : subject
 : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=DBRNh+w8eie1pnv4bam3WplGLm62uPfBpVyhabjWhaE=;
 b=fZ/Sv+aAtuM0jW5LnNl3ji0kpHfO47iOlSgwIoS8DFMQntUjz3siH5MWXvd2ACFWF6Ng
 m8hKdv7ysN/ZrP34xKZ9gpuOXuDjB6RbAxHF2BiaiaYfVLycKqoE3LxfmFK+2//He0yM
 dOBcObvixVBjTzAB04trg3kej5am2nVegHJuSwri4MEV/XReIsiJ/b6MX1GTSHvm7ZxU
 lipe5e0G1GoUIpyxTqf35l5i7oAuJMg1gcI1KLavoct/SbGkqT+obO6FdHTzc7DbpM/C
 sksFGgKgvm67HePoy6GqzPCP+RtDMch7C1inLmk0+tD8ipTcpFtR/vbpYM0tDmcdfaHh eA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33pwrxkrcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 21 Sep 2020 12:08:33 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08LFqtff007008
        for <linux-integrity@vger.kernel.org>; Mon, 21 Sep 2020 16:08:32 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 33n9m8vj73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 21 Sep 2020 16:08:32 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08LG8U4a54067694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 16:08:30 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C2DA136065;
        Mon, 21 Sep 2020 16:08:30 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E62E413604F;
        Mon, 21 Sep 2020 16:08:29 +0000 (GMT)
Received: from [9.85.191.99] (unknown [9.85.191.99])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Sep 2020 16:08:29 +0000 (GMT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>
From:   Ken Goldman <kgold@linux.ibm.com>
Cc:     Ken Goldman <kgoldman@us.ibm.com>
Subject: Measuring an adapter card firmware update into TPM PCRs
Message-ID: <1c806bcb-57a3-c012-4133-3458a06aa81b@linux.ibm.com>
Date:   Mon, 21 Sep 2020 12:08:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_05:2020-09-21,2020-09-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxlogscore=739 clxscore=1015 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use case:  An adapter card, some hardware device, is about to update its 
firmware and then immediately run it.  There is no reboot.

The original code was measured into PCR 2,3.  The adapter card code 
would like to update PCR 2.3 and append to the pre-OS event log before 
it runs the new firmware.

Another use case is a hot plug, where a device was not measured at boot 
but should be measured into PCR 2,3 and pre-OS event log, running post-OS.

- Is this already being done?

- Is there an existing API that the device firmware can call?

- Would the code be running in user space, within the kernel, or is the
card firmware considered something else?
