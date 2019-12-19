Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACE71262FF
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2019 14:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfLSNLy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Dec 2019 08:11:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726719AbfLSNLy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Dec 2019 08:11:54 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJD9uT0105821
        for <linux-integrity@vger.kernel.org>; Thu, 19 Dec 2019 08:11:53 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x08cekyxq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 19 Dec 2019 08:11:52 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 19 Dec 2019 13:11:50 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Dec 2019 13:11:47 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBJDB3tR50331954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 13:11:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76833A4040;
        Thu, 19 Dec 2019 13:11:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19F02A404D;
        Thu, 19 Dec 2019 13:11:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.200.39])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Dec 2019 13:11:44 +0000 (GMT)
Subject: Re: [PATCH v5 1/2] IMA: Define workqueue for early boot "key"
 measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Thu, 19 Dec 2019 08:11:44 -0500
In-Reply-To: <20191218164434.2877-2-nramas@linux.microsoft.com>
References: <20191218164434.2877-1-nramas@linux.microsoft.com>
         <20191218164434.2877-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121913-0008-0000-0000-000003429419
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121913-0009-0000-0000-00004A62AD76
Message-Id: <1576761104.4579.426.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=2 clxscore=1015
 mlxlogscore=989 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912190115
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-12-18 at 08:44 -0800, Lakshmi Ramasubramanian wrote:
> +/*
> + * ima_process_queued_keys() - process keys queued for measurement
> + *
> + * This function sets ima_process_keys to true and processes queued keys.
> + * From here on keys will be processed right away (not queued).
> + */
> +void ima_process_queued_keys(void)
> +{
> +	struct ima_key_entry *entry, *tmp;
> +	bool process = false;
> +
> +	if (ima_process_keys)
> +		return;
> +
> +	/*
> +	 * Since ima_process_keys is set to true, any new key will be
> +	 * processed immediately and not be queued to ima_keys list.
> +	 * First one setting the ima_process_keys flag to true will
> +	 * process the queued keys.
> +	 */
> +	mutex_lock(&ima_keys_mutex);
> +	if (!ima_process_keys) {
> +		ima_process_keys = true;
> +		process = true;
> +	}
> +	mutex_unlock(&ima_keys_mutex);
> +
> +	if (!process)
> +		return;
> +
> +	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
> +		process_buffer_measurement(entry->payload, entry->payload_len,
> +					   entry->keyring_name, KEY_CHECK, 0,
> +					   entry->keyring_name);
> +		list_del(&entry->list);
> +		ima_free_key_entry(entry);
> +	}
> +}
> +

Getting rid of the temporary list is definitely a big improvement.  As
James suggested, using test_and_set_bit() and test_bit() would improve
this code even more.  I think, James correct me if I'm wrong, you
would be able to get rid of both the mutex and "process".

Mimi


>  /**
>   * ima_post_key_create_or_update - measure asymmetric keys
>   * @keyring: keyring to which the key is linked to

