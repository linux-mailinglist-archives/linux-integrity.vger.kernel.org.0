Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 521CC50AD8
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2019 14:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfFXMjs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jun 2019 08:39:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726811AbfFXMjr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jun 2019 08:39:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OCR4LB059350
        for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2019 08:39:46 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2taw5vcnej-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2019 08:39:46 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 24 Jun 2019 13:39:44 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Jun 2019 13:39:40 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5OCdd1e15860188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:39:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B8D242049;
        Mon, 24 Jun 2019 12:39:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 656E64203F;
        Mon, 24 Jun 2019 12:39:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.5])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Jun 2019 12:39:38 +0000 (GMT)
Subject: Re: [PATCH V10 1/3] IMA: Define a new hook to measure the kexec
 boot command line arguments
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     roberto.sassu@huawei.com, vgoyal@redhat.com
Date:   Mon, 24 Jun 2019 08:39:27 -0400
In-Reply-To: <20190624062331.388-2-prsriva02@gmail.com>
References: <20190624062331.388-1-prsriva02@gmail.com>
         <20190624062331.388-2-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062412-0016-0000-0000-0000028BE04C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062412-0017-0000-0000-000032E94C63
Message-Id: <1561379967.4340.3.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240103
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Prakhar,

On Sun, 2019-06-23 at 23:23 -0700, Prakhar Srivastava wrote:
> Currently during soft reboot(kexec_file_load) boot command line
> arguments are not measured. Define hooks needed to measure kexec
> command line arguments during soft reboot(kexec_file_load).
> 
> - A new ima hook ima_kexec_cmdline is defined to be called by the
> kexec code.
> - A new function process_buffer_measurement is defined to measure
> the buffer hash into the IMA measurement list.
> - A new func policy KEXEC_CMDLINE is defined to control the
>  measurement.[Suggested by Mimi]
> 
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>

Thanks!  This patch set is now queued in the next-queued-testing
branch for any last minute comments or Reviews/Acks, before being
staged in the next-integrity branch.

Mimi

