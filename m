Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4564F2CF3B
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2019 21:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfE1TKM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 May 2019 15:10:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727331AbfE1TKM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 May 2019 15:10:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SJ55NO118144
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 15:10:11 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ssa6rsrd7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 15:10:11 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 28 May 2019 20:10:10 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 May 2019 20:10:04 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4SJA3k624248362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 19:10:03 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78A84AE062;
        Tue, 28 May 2019 19:10:03 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB8DCAE05F;
        Tue, 28 May 2019 19:09:59 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.218.160])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue, 28 May 2019 19:09:59 +0000 (GMT)
References: <20190418035120.2354-1-bauerman@linux.ibm.com> <20190418035120.2354-12-bauerman@linux.ibm.com> <1557442889.10635.88.camel@linux.ibm.com>
User-agent: mu4e 1.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI\, Takahiro" <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v10 11/12] ima: Define ima-modsig template
In-reply-to: <1557442889.10635.88.camel@linux.ibm.com>
Date:   Tue, 28 May 2019 16:09:55 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19052819-0060-0000-0000-00000348F56D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011176; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01209916; UDB=6.00635632; IPR=6.00990945;
 MB=3.00027089; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-28 19:10:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052819-0061-0000-0000-0000498886CE
Message-Id: <874l5e75vg.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280119
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Mimi Zohar <zohar@linux.ibm.com> writes:

> On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
>> Define new "d-modsig" template field which holds the digest that is
>> expected to match the one contained in the modsig, and also new "modsig"
>> template field which holds the appended file signature.
>>
>> Add a new "ima-modsig" defined template descriptor with the new fields as
>> well as the ones from the "ima-sig" descriptor.
>>
>> Change ima_store_measurement() to accept a struct modsig * argument so that
>> it can be passed along to the templates via struct ima_event_data.
>>
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>
> Thanks, Roberto. Just some thoughts inline below.
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks!

>> +/*
>> + * Validating the appended signature included in the measurement list requires
>> + * the file hash calculated without the appended signature (i.e., the 'd-modsig'
>> + * field). Therefore, notify the user if they have the 'modsig' field but not
>> + * the 'd-modsig' field in the template.
>> + */
>> +static void check_current_template_modsig(void)
>> +{
>> +#define MSG "template with 'modsig' field also needs 'd-modsig' field\n"
>> +	struct ima_template_desc *template;
>> +	bool has_modsig, has_dmodsig;
>> +	static bool checked;
>> +	int i;
>> +
>> +	/* We only need to notify the user once. */
>> +	if (checked)
>> +		return;
>> +
>> +	has_modsig = has_dmodsig = false;
>> +	template = ima_template_desc_current();
>> +	for (i = 0; i < template->num_fields; i++) {
>> +		if (!strcmp(template->fields[i]->field_id, "modsig"))
>> +			has_modsig = true;
>> +		else if (!strcmp(template->fields[i]->field_id, "d-modsig"))
>> +			has_dmodsig = true;
>> +	}
>> +
>> +	if (has_modsig && !has_dmodsig)
>> +		pr_notice(MSG);
>> +
>> +	checked = true;
>> +#undef MSG
>> +}
>> +
>
> There was some recent discussion about supporting per IMA policy rule
> template formats. This feature will allow just the kexec kernel image
> to require ima-modsig. When per policy rule template formats support
> is upstreamed, this function will need to be updated.

Indeed. Thanks for the clarification. For the next iteration I rebased
on top of Matthew Garret's "IMA: Allow profiles to define the desired
IMA template" patch. I'm currently adapting this check accordingly.

>> @@ -389,3 +425,25 @@ int ima_eventsig_init(struct ima_event_data *event_data,
>>  	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
>>  					     DATA_FMT_HEX, field_data);
>>  }
>> +
>> +int ima_eventmodsig_init(struct ima_event_data *event_data,
>> +			 struct ima_field_data *field_data)
>> +{
>> +	const void *data;
>> +	u32 data_len;
>> +	int rc;
>> +
>> +	if (!event_data->modsig)
>> +		return 0;
>> +
>> +	/*
>> +	 * The xattr_value for IMA_MODSIG is a runtime structure containing
>> +	 * pointers. Get its raw data instead.
>> +	 */
>
> "xattr_value"? The comment needs some clarification.

Oops, forgot to update this comment. This is the new version:

	/*
	 * modsig is a runtime structure containing pointers. Get its raw data
	 * instead.
	 */

--
Thiago Jung Bauermann
IBM Linux Technology Center

