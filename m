Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24C42043A1
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 00:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgFVW2E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 18:28:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59932 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731046AbgFVW1q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 18:27:46 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MM2OiS067839;
        Mon, 22 Jun 2020 18:27:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31tytuhyg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 18:27:43 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05MMPkRX126086;
        Mon, 22 Jun 2020 18:27:43 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31tytuhyfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 18:27:43 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05MMOV2x029015;
        Mon, 22 Jun 2020 22:27:41 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 31sa37v1wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 22:27:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05MMRdQg63635496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 22:27:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4343B4C05A;
        Mon, 22 Jun 2020 22:27:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 338FF4C05E;
        Mon, 22 Jun 2020 22:27:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.202.125])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Jun 2020 22:27:38 +0000 (GMT)
Message-ID: <1592864857.4987.48.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] integrity: Add errno field in audit message
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        sgrubb@redhat.com, paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Date:   Mon, 22 Jun 2020 18:27:37 -0400
In-Reply-To: <20200618211012.2823-1-nramas@linux.microsoft.com>
References: <20200618211012.2823-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_15:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 cotscore=-2147483648 lowpriorityscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-18 at 14:10 -0700, Lakshmi Ramasubramanian wrote:
> Error code is not included in the audit messages logged by
> the integrity subsystem.
> 
> Define a new function integrity_audit_message() that takes error code
> in the "errno" parameter. Add "errno" field in the audit messages logged
> by the integrity subsystem and set the value passed in the "errno"
> parameter.
> 
> [    6.303048] audit: type=1804 audit(1592506281.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=measuring_key cause=ENOMEM comm="swapper/0" name=".builtin_trusted_keys" res=0 errno=-12
> 
> [    7.987647] audit: type=1802 audit(1592506283.312:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=policy_update cause=completed comm="systemd" res=1 errno=0
> 
> [    8.019432] audit: type=1804 audit(1592506283.344:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=measuring_kexec_cmdline cause=hashing_error comm="systemd" name="kexec-cmdline" res=0 errno=-22
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks, Lakshmi.  Steve, Paul, because of the code changes, your tags
were dropped.

Mimi 
