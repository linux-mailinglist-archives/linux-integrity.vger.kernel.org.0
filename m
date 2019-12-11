Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC5FB11AB80
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 14:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfLKNER (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 08:04:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728446AbfLKNER (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 08:04:17 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBCrDfA133146
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2019 08:04:16 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wr8kyvb6j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2019 08:04:14 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 11 Dec 2019 13:04:09 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Dec 2019 13:04:05 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBBD44ls23265648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 13:04:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 615E04203F;
        Wed, 11 Dec 2019 13:04:04 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F7AA42047;
        Wed, 11 Dec 2019 13:04:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.221.15])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Dec 2019 13:04:03 +0000 (GMT)
Subject: Re: [PATCH v1 1/2] IMA: Define workqueue for early boot "key"
 measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Wed, 11 Dec 2019 08:04:02 -0500
In-Reply-To: <1576028407.4579.77.camel@linux.ibm.com>
References: <20191206012936.2814-1-nramas@linux.microsoft.com>
         <20191206012936.2814-2-nramas@linux.microsoft.com>
         <1576028407.4579.77.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121113-0008-0000-0000-0000033FCCAE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121113-0009-0000-0000-00004A5F02D5
Message-Id: <1576069442.4579.131.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110110
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-10 at 20:40 -0500, Mimi Zohar wrote:
> > +void ima_process_queued_keys_for_measurement(void)
> > +{
> > +	struct ima_measure_key_entry *entry, *tmp;
> > +	LIST_HEAD(temp_ima_measure_keys);
> > +
> > +	if (ima_process_keys_for_measurement)
> > +		return;
> > +
> > +	/*
> > +	 * Any queued keys will be processed now. From here on
> > +	 * keys should be processed right away.
> > +	 */
> > +	ima_process_keys_for_measurement = true;
> 
> This function and the ima_queue_key_for_measurement() are not
> exported, so don't require kernel-doc style comments, but at least
> this comment should not be here.  It could be included as part of the
> function description at the head of the function.

Sorry, one more comment.  Appending "_for_measurement" or inserting
"_measure_" makes these function names unnecessarily long.  This
information can be included in the function descriptions.

Mimi


> 
> Remember we don't add code comments needlessly.  Refer to section "8)
> Commenting" in Documentation/process/coding-style.rst.
> 
> > +
> > +	/*
> > +	 * To avoid holding the mutex when processing queued keys,
> > +	 * transfer the queued keys with the mutex held to a temp list,
> > +	 * release the mutex, and then process the queued keys from
> > +	 * the temp list.
> > +	 *
> > +	 * Since ima_process_keys_for_measurement is set to true above,
> > +	 * any new key will be processed immediately and not be queued.
> > +	 */
> > +	INIT_LIST_HEAD(&temp_ima_measure_keys);
> > +
> > +	mutex_lock(&ima_measure_keys_mutex);
> > +
> > +	list_for_each_entry_safe(entry, tmp, &ima_measure_keys, list)
> > +		list_move_tail(&entry->list, &temp_ima_measure_keys);
> > +
> > +	mutex_unlock(&ima_measure_keys_mutex);
> > +
> > +	list_for_each_entry_safe(entry, tmp, &temp_ima_measure_keys, list) {
> > +		process_buffer_measurement(entry->payload, entry->payload_len,
> > +					   entry->keyring_name, KEY_CHECK, 0,
> > +					   entry->keyring_name);
> > +		list_del(&entry->list);
> > +		ima_free_measure_key_entry(entry);
> > +	}
> > +}
> > +
> >  /**
> >   * ima_post_key_create_or_update - measure asymmetric keys
> >   * @keyring: keyring to which the key is linked to
> 

