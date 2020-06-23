Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A321205C4B
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbgFWT6Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 15:58:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46946 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733302AbgFWT6Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 15:58:25 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NJWU5Z167933;
        Tue, 23 Jun 2020 15:58:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ukknsf55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 15:58:22 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05NJWYmk168386;
        Tue, 23 Jun 2020 15:58:21 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ukknsf4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 15:58:21 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NJpGPC015998;
        Tue, 23 Jun 2020 19:58:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 31uk3308nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 19:58:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05NJwHUE64159924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 19:58:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 900DCA405F;
        Tue, 23 Jun 2020 19:58:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52A79A405B;
        Tue, 23 Jun 2020 19:58:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.163.175])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jun 2020 19:58:16 +0000 (GMT)
Message-ID: <1592942295.5389.9.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] IMA: Add audit log for failure conditions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        sgrubb@redhat.com, paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 23 Jun 2020 15:58:15 -0400
In-Reply-To: <20200618211012.2823-2-nramas@linux.microsoft.com>
References: <20200618211012.2823-1-nramas@linux.microsoft.com>
         <20200618211012.2823-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_12:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230130
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-18 at 14:10 -0700, Lakshmi Ramasubramanian wrote:
> process_buffer_measurement() and ima_alloc_key_entry() functions need to
> log an audit message for auditing integrity measurement failures.
> 
> Add audit message in these two functions. Remove "pr_devel" log message
> in process_buffer_measurement().
> 
> Sample audit messages:
> 
> [    6.303048] audit: type=1804 audit(1592506281.627:2): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=kernel op=measuring_key
> cause=ENOMEM comm="swapper/0" name=".builtin_trusted_keys" res=0
> errno=-12

My only concern is that auditing -ENOMEM will put additional memory
pressure on the system.  I'm not sure if this is a concern and, if so,
how it should be handled.

> 
> [    8.019432] audit: type=1804 audit(1592506283.344:10): pid=1
> uid=0 auid=4294967295 ses=4294967295
> subj=system_u:system_r:init_t:s0 op=measuring_kexec_cmdline
> cause=hashing_error comm="systemd" name="kexec-cmdline" res=0
> errno=-22
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
