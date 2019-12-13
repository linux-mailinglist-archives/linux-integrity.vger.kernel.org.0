Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C137D11DC27
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2019 03:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbfLMCdH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 21:33:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731328AbfLMCdG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 21:33:06 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBD2WNPp143624
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2019 21:33:05 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wusvhd9hk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2019 21:33:05 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 13 Dec 2019 02:33:03 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Dec 2019 02:33:00 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBD2Wxjf50528344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 02:32:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 248064C044;
        Fri, 13 Dec 2019 02:32:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F04E34C040;
        Fri, 13 Dec 2019 02:32:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.206.100])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Dec 2019 02:32:57 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] IMA: Define workqueue for early boot "key"
 measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Thu, 12 Dec 2019 21:32:57 -0500
In-Reply-To: <6e0dad33-66f9-4807-d08d-ff30396cec5e@linux.microsoft.com>
References: <20191213004250.21132-1-nramas@linux.microsoft.com>
         <20191213004250.21132-2-nramas@linux.microsoft.com>
         <1576202134.4579.189.camel@linux.ibm.com>
         <6e0dad33-66f9-4807-d08d-ff30396cec5e@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121302-0020-0000-0000-00000397A111
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121302-0021-0000-0000-000021EEACE1
Message-Id: <1576204377.4579.206.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_08:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130020
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-12-12 at 17:59 -0800, Lakshmi Ramasubramanian wrote:
> On 12/12/19 5:55 PM, Mimi Zohar wrote:
> >> +/*
> >> + * ima_process_queued_keys() - process keys queued for measurement
> >> + *
> >> + * This function sets ima_process_keys to true and processes queued keys.
> >> + * From here on keys will be processed right away (not queued).
> >> + */
> >> +void ima_process_queued_keys(void)
> >> +{
> >> +	struct ima_key_entry *entry, *tmp;
> >> +	LIST_HEAD(temp_ima_keys);
> >> +
> >> +	if (ima_process_keys)
> >> +		return;
> >> +
> >> +	/*
> >> +	 * To avoid holding the mutex when processing queued keys,
> >> +	 * transfer the queued keys with the mutex held to a temp list,
> >> +	 * release the mutex, and then process the queued keys from
> >> +	 * the temp list.
> >> +	 *
> >> +	 * Since ima_process_keys is set to true, any new key will be
> >> +	 * processed immediately and not be queued.
> >> +	 */
> >> +	INIT_LIST_HEAD(&temp_ima_keys);
> >> +
> >> +	mutex_lock(&ima_keys_mutex);
> > 
> > Don't you need a test here, before setting ima_process_keys?
> > 
> > 	if (ima_process_keys)
> > 		return;
> > 
> > Mimi
> 
> That check is done before the comment - at the start of 
> ima_process_queued_keys().

The first test prevents taking the mutex unnecessarily.

Mimi


> +void ima_process_queued_keys(void)
> +{
> +	struct ima_key_entry *entry, *tmp;
> +	LIST_HEAD(temp_ima_keys);
> +
> +	if (ima_process_keys)
> +		return;
> 
> thanks,
>   -lakshmi

