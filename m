Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47CB29AB0
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2019 17:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389654AbfEXPMX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 May 2019 11:12:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389292AbfEXPMW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 May 2019 11:12:22 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4OEvunQ027346
        for <linux-integrity@vger.kernel.org>; Fri, 24 May 2019 11:12:21 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2spjsb8xwg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 24 May 2019 11:12:20 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 24 May 2019 16:12:18 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 May 2019 16:12:15 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4OFCEZB40501408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 15:12:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14B2342049;
        Fri, 24 May 2019 15:12:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A2464204B;
        Fri, 24 May 2019 15:12:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.111.39])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 May 2019 15:12:12 +0000 (GMT)
Subject: Re: [PATCH v6 2/3] add a new ima template field buf
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mjg59@google.com, roberto.sassu@huawei.com, vgoyal@redhat.com
Date:   Fri, 24 May 2019 11:12:02 -0400
In-Reply-To: <20190521000645.16227-3-prsriva02@gmail.com>
References: <20190521000645.16227-1-prsriva02@gmail.com>
         <20190521000645.16227-3-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052415-0016-0000-0000-0000027F1352
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052415-0017-0000-0000-000032DC108A
Message-Id: <1558710722.3977.68.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=984 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905240100
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-05-20 at 17:06 -0700, Prakhar Srivastava wrote:
> A buffer(cmdline args) measured into ima cannot be appraised
> without already being aware of the buffer contents.Since we
> don't know what cmdline args will be passed (or need to validate
> what was passed) it is not possible to appraise it. 
> 
> Since hashs are non reversible the raw buffer is needed to 
> recompute the hash.
> To regenrate the hash of the buffer and appraise the same
> the contents of the buffer need to be available.
> 
> A new template field buf is added to the existing ima template
> fields, which can be used to store/read the buffer itself.
> Two new fields are added to the ima_event_data to carry the
> buf and buf_len whenever necessary.
> 
> Updated the process_buffer_measurement call to add the buf
> to the ima_event_data.
> process_buffer_measurement added in "Add a new ima hook 
> ima_kexec_cmdline to measure cmdline args"
> 
> - Add a new template field 'buf' to be used to store/read
> the buffer data.
> - Added two new fields to ima_event_data to hold the buf and
> buf_len [Suggested by Roberto]
> -Updated process_buffer_meaurement to add the buffer to
> ima_event_data

This patch description can be written more concisely.

Patch 1/3 in this series introduces measuring the kexec boot command
line.  This patch defines a new template field for storing the kexec
boot command line in the measurement list in order for a remote
attestation server to verify.

As mentioned, the first patch description should include a shell
command for verifying the digest in the kexec boot command line
measurement list record against /proc/cmdline.  This patch description
should include a shell command showing how to verify the digest based
on the new field.  Should the new field in the ascii measurement list
be displayed as a string, not hex?

Mimi

