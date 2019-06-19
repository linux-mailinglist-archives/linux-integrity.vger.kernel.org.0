Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 073744BC73
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2019 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfFSPHZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jun 2019 11:07:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729642AbfFSPHX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jun 2019 11:07:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JF4oks081576
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 11:07:21 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t7p434pue-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 11:07:21 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 19 Jun 2019 16:07:19 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Jun 2019 16:07:16 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5JF7F9v49676398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 15:07:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2FE74C046;
        Wed, 19 Jun 2019 15:07:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D5B64C044;
        Wed, 19 Jun 2019 15:07:15 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jun 2019 15:07:14 +0000 (GMT)
Subject: Re: [PATCH V4] IMA: support for per policy rule template formats
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, prsriva02@gmail.com,
        bauerman@linux.ibm.com, roberto.sassu@huawei.com,
        Matthew Garrett <mjg59@google.com>
In-Reply-To: <20190618202428.10320-1-matthewgarrett@google.com>
References: <20190618202428.10320-1-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 18 Jun 2019 22:19:11 -0400
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061915-0020-0000-0000-0000034B8629
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061915-0021-0000-0000-0000219EDABD
Message-Id: <1560910751.4157.4.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=930 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190122
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-06-18 at 13:24 -0700, Matthew Garrett wrote:
> @@ -1134,6 +1144,27 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>                         else
>                                 entry->flags |= IMA_PCR;
>  
> +                       break;
> +               case Opt_template:
> +                       ima_log_string(ab, "template", args[0].from);
> +                       if (entry->action != MEASURE) {
> +                               result = -EINVAL;
> +                               break;
> +                       }
> +                       template_desc = lookup_template_desc(args[0].from);
> +                       if (!template_desc || entry->template) {
> +                               result = -EINVAL;
> +                       } else {
> +                               /*
> +                                * template_desc_init_fields() does nothing
> +                                * if the template is already initialised,
> +                                * so it's safe to do this unconditionally
> +                                */
> +                               template_desc_init_fields(template_desc->fmt,
> +                                                &(template_desc->fields),
> +                                                &(template_desc->num_fields));
> +                               entry->template = template_desc;
> +                       }

The "else" isn't necessary, causing unnecessary indenting.  Just add a
break.

Mimi

>                         break;
>                 case Opt_err:
>                         ima_log_string(ab, "UNKNOWN", p);

