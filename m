Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA2654318F
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jun 2022 15:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbiFHNil (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jun 2022 09:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbiFHNik (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jun 2022 09:38:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932881285F2;
        Wed,  8 Jun 2022 06:38:39 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 258C7VNb023072;
        Wed, 8 Jun 2022 06:38:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=TSLttvDq+/lOa5ZhC4DOjCnt72LdC6d1Ni/fxLZjufQ=;
 b=kLZXDNTnJJTEdT8A9ZSeYe9JxyXUtsHPetUB4VQ36RnBpgnATkS5nf9iMdHfSXWlO5Xt
 GZg7LSdXWctMeEBhmYU4RoX0wYs9OmQjESNqc9w7ile+wrdM4QL0LS09kiwrmfe2alB5
 +sXt65Vr6TBBpm1Og5mJ9wwXkvlw9sAC1Mg= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ghy459ryj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 06:38:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBmqDdl23BMsgUlqvjI9g/seeSlyh46xIjdW0bsnG40n+FSeTMXQr2RdCo3owOOOPb2i2AgQLDd8m+jhwKQclVwcoB+hh/D1p6QoipYjQVArKtAMDM4euslNsXmdSNEXPGVpBio5TYDxsakJ5TBT91C7aOruAWeprupttP1jbprzelXbI+UkrS8bXXAXZbjuGqRgkZM+Ff0zy1P7eCe530uaPinVewhrs1Vvbt5Et49f6AOzDjedxBMsmHfNoOW68j1JWOJOt0+L88SdbXlBqzwedpmiO3kDbbrB0R7xfaIsCU5nr1aLtVRNjBd2f2pgcGXgLNwLz4ndDjqyDNmofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSLttvDq+/lOa5ZhC4DOjCnt72LdC6d1Ni/fxLZjufQ=;
 b=ZYkIyssyZvPpYxXD9lrj4FK+Er8uuOnu4Zy8JkUNtQ0GUtKnllO6AEcekkkKlp6A8Ly15kDGYUWOJFaCvu/KtkqQhu7EmsxeH92HX4OMA5zUzYEQPX9umIDg5kJhnYfKgIz55BeFXMH2JAOSMEubRdyNadu6Wx6uVkjn+181Fc+ruUjOS4SKP8342eYbBEe7H7J/eZQAgi5nKSbaG2i2Y1xLEeX0fSXW3UId9nM2GaRxxWhQt8ZlWpNtg3G23LdC6nMnnMh5yEZJCTZjPRcXB/UmDaIZCGMe3WD9ZWpYw/TjWAnMaluaj42T5f7lqBD+jbmuBWbvaMMySBeGk5q++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by PH0PR15MB4166.namprd15.prod.outlook.com (2603:10b6:510:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 8 Jun
 2022 13:38:35 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab%9]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 13:38:35 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Jianglei Nie <niejianglei2021@163.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Fix memory leak in tpm2_key_encode()
Thread-Topic: [PATCH v2] KEYS: trusted: Fix memory leak in tpm2_key_encode()
Thread-Index: AQHYezzkL7mbniGhFUCacTFHDtg8861Fg5oA
Date:   Wed, 8 Jun 2022 13:38:35 +0000
Message-ID: <YqCmVi3J10Tcx0Wk@noodles-fedora.dhcp.thefacebook.com>
References: <20220608131732.550234-1-niejianglei2021@163.com>
In-Reply-To: <20220608131732.550234-1-niejianglei2021@163.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3f83d67-55ec-49dc-371a-08da49543000
x-ms-traffictypediagnostic: PH0PR15MB4166:EE_
x-microsoft-antispam-prvs: <PH0PR15MB4166B0108244EDCDAF7725F1C1A49@PH0PR15MB4166.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6xqUJCYgAhSroJ763aHTuUSOS7no2+HrR9k8dVwH1DENyDhbuI6o6n40XRBuNSoXQc+Mv5dITZsMrFw80grZjzZwaVDCzSFS7AdVC+samjMokfs8ZniPoiiHpPZ0i/CjLdXL5oUpN1ZvEO3ymXEVqV6l8cN+DDVWu6+aMGrO3z8xKB956DIbA+cI0dApoExqKOkaGwGEWOPmEE6XKgZjyve3AtXT7eqb5dpOVWRVpzMou+GL+zXEubyQ57nUvOG73esh5kDlhwnWrlh6lqS+z4xBajHMXmULBx/GD2ReZQeMbXsnLqV+IqemQaNFiEcmgNEucb/TBcr+OLTA5T0r848nOTKCKLWut2sXpL/Q58CpcSDLejAl3NhqVpfNt6FF7azcywTCNQaCpN0pw49JDQ5iCOtxy7cyF3fMdbd0RMVvX/zd37MeOFszESmljeHalSteOzCogVpQKa+eG0DCFTBdBLecTp/Kn0W8EHZ6vwLBpTU8qP7fJaqNgvq67Jj6WHRmxggUPYanP5vninfOVRkXrinyoSbVjus5aGuJiUfp+a9BwyIu+1QVvKFQXsNI3BUfFs/5SSw3qVG8iJrsAwwcdlCH98iz8Mrq8pqnMzUiGZF6yaGtz2bfu8Qv2kUIPqWFxlTcX8kofJmvGTpD58Wv/emSwwM/8ZV+6UlN7DQs2APqxVfW+Dp8APlYHxlXfoAX/uA0keBafv94KeCXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(6512007)(71200400001)(508600001)(6486002)(316002)(2906002)(86362001)(54906003)(6916009)(38070700005)(122000001)(9686003)(26005)(6506007)(38100700002)(186003)(76116006)(8936002)(66946007)(66446008)(64756008)(8676002)(4326008)(66556008)(5660300002)(66476007)(7416002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ekO8UsaN1OvWIXaNIIYaRPgrB1lSv6sFEvzJ8DjGMxNk24EeAJ4vA19GB9lp?=
 =?us-ascii?Q?Oo1C8Pco6pD5Af7LLlnq1Qfya9iXnKaIhgjsHmP2YBgf0fz2Bfj44dyU4Ley?=
 =?us-ascii?Q?CuwDq/SlIEzsL4wsVc5jF+jXp+QXIlU4TiJrn77S9tAwKI3qPWNtrht6Q4bR?=
 =?us-ascii?Q?1Dob357M037SkwA/jvAP1/V+XDU+ahsYDK710yLdCvCzPtjiXvopsc/5QqNN?=
 =?us-ascii?Q?ys0MNSWNtJRqT7N5v+BgL1Rlt8yCBwJm9FExwxUeYyI2fkUrOqTQHURlUdpR?=
 =?us-ascii?Q?hiR706gUwnJTDiywLujp6IjkdjBTaLKKVVjtGdwPESuL8fM7v2UkGq+rbejA?=
 =?us-ascii?Q?rCsvUADL3XT7+7b1ytDI3vAKe0zsJrBaGOqx1PbMF/tJQgvP9L3SEHOmi4l7?=
 =?us-ascii?Q?RLG0SUc4WYQnXjmZ6tHbIsLFQ+eC96FN/Wh249DiSh1dn2UzXN+xcJCcjtcA?=
 =?us-ascii?Q?0oJAFKrq6cI7ryhdw/k47VSV8U/bFd+lDyhRNMdoojXXNva1j2gKmcOR3UOQ?=
 =?us-ascii?Q?eXArFPDArxVMHn/IhA8OcQ/ciX/cPAeZ09pBk97mzmRgb98j63yfm3AIsT6s?=
 =?us-ascii?Q?XrUwAduW4SuaYOOaCSyxNVd1BMedERqJAfvAQ+IHs30jsES0ToSl1WNiMVST?=
 =?us-ascii?Q?iQBcUrO9h6zdw8zSVs+YIpCdLWJD6q8xDZXXJ9FB0UCaQHCnmzBhBYW+7oRA?=
 =?us-ascii?Q?LvF+d59cmeXbA4D0paBz6U9jgl9EcUq5d27WtPXxfMZ5rIOUd08z0BLbFuN3?=
 =?us-ascii?Q?nbslu5xJ+sGkPraooTpsS5/0jtUzdiI+zJo5QPIMny6Awiet9ItGCP0GAUGD?=
 =?us-ascii?Q?Tu7+kZVSfMKB7dWWREW0y5njIdw+5jnvD4fBRayUZH5XFtNVBin2Vv5ZuHeq?=
 =?us-ascii?Q?wT9JcDjopgWBKvslB15dn6bOS6kjF8w+GK9Srcr2wU3WV47ZTlEXqKntpgND?=
 =?us-ascii?Q?+e/Jsnl09oP70Ka/ivrHn6iv9bBYNkegdEQQ0cN1ksZUjh+PLLbo35XgCwrp?=
 =?us-ascii?Q?BGqTAfUjodZnQS/6kXS6L9udLvTFX87rCrPq9nwrOj1b5ureVv76RH4Ku0nr?=
 =?us-ascii?Q?mM/aNYTa9CLOXm0M5hWMFCS9VsWjeDp3bkl9EMI/0/SAf+tA0eEq0R2AppYA?=
 =?us-ascii?Q?eWouYclxCxw1hWAtV7zFqXAaxY4iAR2FUxGZ8kOwWVp85oBwXpliqFusi+Bl?=
 =?us-ascii?Q?ZxiwRcr22UjC1jorK1q3l5odZh7E9+kxXaXSYcuBunejCwNzLPa0fdFg0kWG?=
 =?us-ascii?Q?XvUzyv0LBGtVIkopAwdm2ywc47v8l8Lc4f2e6TzqRLi6xGj5qL3t4O02Aqgo?=
 =?us-ascii?Q?Qa7j4sf+2LB9TUdUEOOJJFjhLwvyWIqY9rHoDtxwp2ZvpZ17thxKln6hIxaK?=
 =?us-ascii?Q?zM44WroS0SdkVOXB9Qzwn0Cwcb8L25JtLQQkEaMwyRGPiazdn//Gh4XXf86m?=
 =?us-ascii?Q?e94GfeftqEeRG9zpz06oMfEBwzAm52SnGV49lz2RbvFyRjfYNYjbOPwTPUZN?=
 =?us-ascii?Q?Wf/9FsddBNCB3CZr7aME8/iQUmWE/tMt/03+ABvr8rRF5Tt1q++6ZVkm1HeB?=
 =?us-ascii?Q?CIiTC2nIRCQg0yPvckbKaatPA1p8n7p8+yLQYSbAwbjF8QGBV901HFjSUN2S?=
 =?us-ascii?Q?gVh1ZMUZomyfq+jeMkwG3kIH7SSIYKzmTE640zJvDSRxS/pd2WD4SlpGpLwf?=
 =?us-ascii?Q?GpFocpBHu73Q6F6NT7QI82yfErQvZhtVMKaqQzQrQpnRBt9QHxdm+0WZEFjr?=
 =?us-ascii?Q?pwgk1umFPA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C21F05C868FD6640BA95D6CBAF08E452@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f83d67-55ec-49dc-371a-08da49543000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 13:38:35.7122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wWKI8u6/PnVcsr1HhFrX5ZluzCMCy6gWMzcNe53wqhZXZTHvVRyWXwCM+DHT3ZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4166
X-Proofpoint-ORIG-GUID: Z9wUTYugkXmfQ_W1kvcNiflzqoDfh99X
X-Proofpoint-GUID: Z9wUTYugkXmfQ_W1kvcNiflzqoDfh99X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_04,2022-06-07_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 08, 2022 at 09:17:32PM +0800, Jianglei Nie wrote:
> tpm2_key_encode() allocates a memory chunk from scratch with kmalloc(),
> but it is never freed, which leads to a memory leak. Free the memory
> chunk with kfree() in the return path.

This change only does the kfree in the success path; "out" just returns
the error without freeing the memory.

> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 0165da386289..8b7ab22950d1 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -32,6 +32,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  			   struct trusted_key_options *options,
>  			   u8 *src, u32 len)
>  {
> +	int err;
>  	const int SCRATCH_SIZE = PAGE_SIZE;
>  	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>  	u8 *work = scratch, *work1;
> @@ -57,8 +58,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  		unsigned char bool[3], *w = bool;
>  		/* tag 0 is emptyAuth */
>  		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> -		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
> -			return PTR_ERR(w);
> +		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
> +			err = PTR_ERR(w);
> +			goto out;
> +		}
>  		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
>  	}
>  
> @@ -69,8 +72,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	 * trigger, so if it does there's something nefarious going on
>  	 */
>  	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
> -		 "BUG: scratch buffer is too small"))
> -		return -EINVAL;
> +		 "BUG: scratch buffer is too small")) {
> +		err = -EINVAL;
> +		goto out;
> +	}
>  
>  	work = asn1_encode_integer(work, end_work, options->keyhandle);
>  	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
> @@ -79,10 +84,16 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	work1 = payload->blob;
>  	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
>  				     scratch, work - scratch);
> -	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
> -		return PTR_ERR(work1);
> +	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +	kfree(scratch);
>  
>  	return work1 - payload->blob;
> +
> +out:
> +	return err;
>  }
>  
>  struct tpm2_key_context {
> -- 
> 2.25.1
