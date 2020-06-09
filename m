Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47681F41B1
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2020 19:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgFIRFB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Jun 2020 13:05:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731204AbgFIRFB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jun 2020 13:05:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059H2nR1129045;
        Tue, 9 Jun 2020 13:04:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31jayd7x5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 13:04:59 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 059H2uZe129877;
        Tue, 9 Jun 2020 13:04:58 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31jayd7x4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 13:04:58 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 059GpPt1017646;
        Tue, 9 Jun 2020 17:04:56 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s7xb8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 17:04:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 059H4s9F64946398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 17:04:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1FB9A4040;
        Tue,  9 Jun 2020 17:04:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27BBDA404D;
        Tue,  9 Jun 2020 17:04:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.146.136])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jun 2020 17:04:53 +0000 (GMT)
Message-ID: <1591722292.5567.28.camel@linux.ibm.com>
Subject: Re: [PATCH v3] IMA: Add audit log for failure conditions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 13:04:52 -0400
In-Reply-To: <20200608215343.4491-1-nramas@linux.microsoft.com>
References: <20200608215343.4491-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_10:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090130
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-06-08 at 14:53 -0700, Lakshmi Ramasubramanian wrote:
> The final log statement in process_buffer_measurement() for failure
> condition is at debug level. This does not log the message unless
> the system log level is raised which would significantly increase
> the messages in the system log. Change this log message to an audit
> message for better triaging failures in the function.

We need to differentiate between emitting the error number for
debugging purposes and auditing integrity failures.  The purpose of
this patch should be to audit integrity failures.  Please update the
patch description.

(Including the "errno" as Steve suggested would be fine.)

> 
>  out:
> -	if (ret < 0)
> -		pr_devel("%s: failed, result: %d\n", __func__, ret);
> +	if (ret < 0) {
> +		snprintf(measurement_audit_cause, AUDIT_CAUSE_LEN_MAX,
> +			 "%s(%d)", audit_cause, ret);

Please remove this.

> +
> +		switch (func) {
> +		case KEXEC_CMDLINE:
> +			op = "measuring_kexec_cmdline";
> +			break;
> +		case KEY_CHECK:
> +			op = "measuring_keys";
> +			break;
> +		default:
> +			op = "measuring_blacklisted_hash";
> +			break;
> +		}

Instead of a switch, define a string array based on func.

> +
> +		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, eventname,
> +				    op, measurement_audit_cause, ret, 0);

Use "audit_cause".

thanks,

Mimi

> +	}

