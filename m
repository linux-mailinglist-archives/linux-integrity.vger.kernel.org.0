Return-Path: <linux-integrity+bounces-1429-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FE8861927
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 18:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBFF284915
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D409B823A1;
	Fri, 23 Feb 2024 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzpSfwIc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC56946AB;
	Fri, 23 Feb 2024 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708548; cv=none; b=mAnU+kSGC2vlZS2uHvVc7RVtjgvpjtgL/zf/W15FBkgmkuV2pzsFRWYh6H+ZLE684n1gxDg4wyVDS8Rq9tTAM6fOAZad+99a6GeqmL/mrhqEPtBbGsiki76j6De/2CfzNDa/7+1+wA3Lc/3sB5OcLIjkb2Xj84VUWB5ve4NPCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708548; c=relaxed/simple;
	bh=JBPyeZRh99c/zDVlPHgiVUDEfdWyaaSte+6WmKr2qTg=;
	h=Content-Type:Mime-Version:Date:To:Cc:Subject:From:Message-Id:
	 References:In-Reply-To; b=b86OPnywfqiDcNerKrnEpvqk/U/bEfFZVwjxi6KKp8JN4CSqud3k/pm66Gio/ntoMr9K/+KFbJlzPF+Tm1FKzG/vhDVIxCd3yai3aSRDjzAwkKqAn3gAR6FyXmlFOTk1kddp2F1G6+I3Pr8RGQ3G/ygn18i5XGEVRVhDAH3/oIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzpSfwIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C258C433F1;
	Fri, 23 Feb 2024 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708548;
	bh=JBPyeZRh99c/zDVlPHgiVUDEfdWyaaSte+6WmKr2qTg=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=LzpSfwIcn2Qdci4qJzYP9JkG6fyRjtLCPLHdqrf6HPqj3j1Tlv/vcwUIBcktpSfzY
	 RGNWXuAMWcHMa6ILKpN92GtNp5IBH1f3b3BQuGhsvqyKo4uBhvaXqnN1E2vbG+z7N/
	 Vdf4iO3qL6yOdP4pxvG+uzfy24mhX9R3AezTEoT5Lsfodf+Z4H1tbl+yXfdNMG+G11
	 bmK3ozw7cqZdwv6XhSS/wcsgAc5Ub8Y2g/xrbtKgKOt8X0ggv7WM6Uq7QCIMKb4fnX
	 0bc/NeSaZSvTJoVLGnwTUVrG8SdBNX84Fjc0UEITLsod0XUv8X14/ZWRENs7/PpxqX
	 gr1usaQJIMlCw==
Content-Type: multipart/mixed;
 boundary=43fa6918cd2487f00ad85ed391d18ab445a29eba828d9f1bc1da571555fc
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 23 Feb 2024 19:15:45 +0200
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v7 19/21] tpm: add the null key name as a sysfs export
From: "Jarkko Sakkinen" <jarkko@kernel.org>
Message-Id: <CZCMK5JHJM7T.21CN8KO8GQ4GG@suppilovahvero>
X-Mailer: aerc 0.15.2
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-20-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240213171334.30479-20-James.Bottomley@HansenPartnership.com>

--43fa6918cd2487f00ad85ed391d18ab445a29eba828d9f1bc1da571555fc
Content-Type: multipart/alternative;
 boundary=372a0d9bb51f5c1eb4fd326189020b4bede63763ced15460f16944d0007a

--372a0d9bb51f5c1eb4fd326189020b4bede63763ced15460f16944d0007a
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Tue Feb 13, 2024 at 7:13 PM EET, James Bottomley wrote:
> This is the last component of encrypted tpm2 session handling that
> allows us to verify from userspace that the key derived from the NULL
> seed genuinely belongs to the TPM and has not been spoofed.
>
> The procedure for doing this involves creating an attestation identity
> key (which requires verification of the TPM EK certificate) and then
> using that AIK to sign a certification of the Elliptic Curve key over
> the NULL seed.  Userspace must create this EC Key using the parameters
> prescribed in TCG TPM v2.0 Provisioning Guidance for the SRK ECC; if
> this is done correctly the names will match and the TPM can then run a
> TPM2_Certify operation on this derived primary key using the newly
> created AIK.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> ---
> v6: change config name
> v7: add review
> ---
>  drivers/char/tpm/tpm-sysfs.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index 54c71473aa29..94231f052ea7 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -309,6 +309,21 @@ static ssize_t tpm_version_major_show(struct device =
*dev,
>  }
>  static DEVICE_ATTR_RO(tpm_version_major);
> =20
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +static ssize_t null_name_show(struct device *dev, struct device_attribut=
e *attr,
> +			      char *buf)
> +{
> +	struct tpm_chip *chip =3D to_tpm_chip(dev);
> +	int size =3D TPM2_NAME_SIZE;
> +
> +	bin2hex(buf, chip->null_key_name, size);
> +	size *=3D 2;
> +	buf[size++] =3D '\n';
> +	return size;
> +}
> +static DEVICE_ATTR_RO(null_name);
> +#endif
> +
>  static struct attribute *tpm1_dev_attrs[] =3D {
>  	&dev_attr_pubek.attr,
>  	&dev_attr_pcrs.attr,
> @@ -326,6 +341,9 @@ static struct attribute *tpm1_dev_attrs[] =3D {
> =20
>  static struct attribute *tpm2_dev_attrs[] =3D {
>  	&dev_attr_tpm_version_major.attr,
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +	&dev_attr_null_name.attr,
> +#endif
>  	NULL
>  };
> =20

Ditto.

Could also have my tested-by. I removed my test suite from Github.
Soon relocating it to gitlab. The reason being that I'm also
enabling full keyutils test suite in it and in more distant
future might refactor it into a CI test (ATM do not have
bandwidth to accomplish the last step).

David, I've been carrying couple of minor fixes to keyutils test.
When you have time, could you check if they make sense (attached).

Came to mind while reviewing this and they are pretty small so
maybe they could be picked like this.

BR, Jarkko

--372a0d9bb51f5c1eb4fd326189020b4bede63763ced15460f16944d0007a--

--43fa6918cd2487f00ad85ed391d18ab445a29eba828d9f1bc1da571555fc
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-test-lsb_release-fix.patch
Content-Type: text/x-patch; charset=utf-8;
 name=0001-test-lsb_release-fix.patch

RnJvbSBkMzQ3MmE4MWRlY2MwYTk4MmI4MTU0YmU3Yjg3MzQzNmE5MTg3M2Q4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgpE
YXRlOiBUdWUsIDE5IERlYyAyMDIzIDEyOjI3OjA5ICswMjAwClN1YmplY3Q6IFtQQVRDSCAxLzRd
IHRlc3Q6IGNoZWNrIGZvciBsc2JfcmVsZWFzZSBjb21tYW5kIGV4aXN0ZW5jZSBiZWZvcmUKIGFw
cGx5aW5nIGl0CgpSZXF1aXJpbmcgYGxzYl9yZWxlYXNlYCBtYWtlcyBrZXl1dGlscyB0ZXN0IHN1
aXRlIHZlcnkgdW5yb2J1c3QgdG93YXJkcwpDSS4gVGhlcmVmb3JlLCBjaGVjayBpdHMgZXhpc3Rl
bmNlIGJlZm9yZSBhcHBseWluZyB0aGUgY29tbWFuZC4KClNpZ25lZC1vZmYtYnk6IEphcmtrbyBT
YWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+Ci0tLQogdGVzdHMvcHJlcGFyZS5pbmMuc2ggfCAx
NSArKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvcHJlcGFyZS5pbmMuc2ggYi90ZXN0cy9wcmVw
YXJlLmluYy5zaAppbmRleCA0MDMzZDY5Li4xYTFhY2M5IDEwMDY0NAotLS0gYS90ZXN0cy9wcmVw
YXJlLmluYy5zaAorKysgYi90ZXN0cy9wcmVwYXJlLmluYy5zaApAQCAtNjYsMTMgKzY2LDE2IEBA
IHRoZW4KICAgICBlY2hvIC1uID4kT1VUUFVURklMRQogZmkKIAotY2FzZSBgbHNiX3JlbGVhc2Ug
LWkgLXNgIGluCi0gICAgRmVkb3JhKikJCU9TRElTVD1GZWRvcmE7OwotICAgIFJlZEhhdEVudGVy
cHJpc2UqKQlPU0RJU1Q9UkhFTDs7Ci0gICAgKikJCQlPU0RJU1Q9VW5rbm93bjs7Ci1lc2FjCitp
ZiBjb21tYW5kIC12IGxzYl9yZWxlYXNlICY+IC9kZXYvbnVsbAordGhlbgorICAgIGNhc2UgYGxz
Yl9yZWxlYXNlIC1pIC1zYCBpbgorICAgICAgICBGZWRvcmEqKSAgICAgICAgICAgIE9TRElTVD1G
ZWRvcmE7OworICAgICAgICBSZWRIYXRFbnRlcnByaXNlKikgIE9TRElTVD1SSEVMOzsKKyAgICAg
ICAgKikgICAgICAgICAgICAgICAgICBPU0RJU1Q9VW5rbm93bjs7CisgICAgZXNhYwogCi1PU1JF
TEVBU0U9YGxzYl9yZWxlYXNlIC1yIC1zYAorICAgIE9TUkVMRUFTRT1gbHNiX3JlbGVhc2UgLXIg
LXNgCitmaQogCiBLRVlVVElMU1ZFUj1ga2V5Y3RsIC0tdmVyc2lvbiAyPi9kZXYvbnVsbGAKIGlm
IFsgLW4gIiRLRVlVVElMU1ZFUiIgXQotLSAKMi40MC4xCgo=
--43fa6918cd2487f00ad85ed391d18ab445a29eba828d9f1bc1da571555fc
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0002-test-fix-typo.patch
Content-Type: text/x-patch; charset=utf-8; name=0002-test-fix-typo.patch

RnJvbSAxOWQ1NGFjYjU3ZTg5NjBlMzg2MTE5MDg4ZDU3ZTIzODVjNzE4NjJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgpE
YXRlOiBGcmksIDIyIERlYyAyMDIzIDIxOjQyOjExICswMjAwClN1YmplY3Q6IFtQQVRDSCAyLzRd
IHRlc3Q6IGZpeCB0eXBvIGluIGJ1aWx0aW5fdHJ1c3RlZC9ydW50ZXN0LnNoCgpzL2ZhaWwvZmFp
bGVkLwoKU2lnbmVkLW9mZi1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz4K
LS0tCiB0ZXN0cy9mZWF0dXJlcy9idWlsdGluX3RydXN0ZWQvcnVudGVzdC5zaCB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3Rlc3RzL2ZlYXR1cmVzL2J1aWx0aW5fdHJ1c3RlZC9ydW50ZXN0LnNoIGIvdGVzdHMvZmVhdHVy
ZXMvYnVpbHRpbl90cnVzdGVkL3J1bnRlc3Quc2gKaW5kZXggNmJkMDczYi4uYzA3MzZkNiAxMDA2
NDQKLS0tIGEvdGVzdHMvZmVhdHVyZXMvYnVpbHRpbl90cnVzdGVkL3J1bnRlc3Quc2gKKysrIGIv
dGVzdHMvZmVhdHVyZXMvYnVpbHRpbl90cnVzdGVkL3J1bnRlc3Quc2gKQEAgLTI0LDcgKzI0LDcg
QEAgaWRfa2V5IC0tdG89YmxrICU6LmJsYWNrbGlzdAogIyBUaGVyZSBzaG91bGQgYmUgYXQgbGVh
c3Qgb25lIGJ1aWx0LWluIHRydXN0ZWQga2V5IGZvciBtb2R1bGUgc2lnbmluZy4KIGxpc3Rfa2V5
cmluZyAkYnRrCiBleHBlY3Rfa2V5cmluZ19ybGlzdCBia2V5cwotaWYgWyBgZWNobyAkYmtleXMg
fCB3YyAtd2AgPSAwIF07IHRoZW4gZmFpbDsgZmkKK2lmIFsgYGVjaG8gJGJrZXlzIHwgd2MgLXdg
ID0gMCBdOyB0aGVuIGZhaWxlZDsgZmkKIAogIyBDaGVjayB3ZSBjYW4ndCBhZGQgcmFuZG9tIGtl
eXMgdG8gdGhvc2Uga2V5cmluZ3MKIG1hcmtlciAiVFJZIEFERElORyBVU0VSIEtFWVMiCi0tIAoy
LjQwLjEKCg==
--43fa6918cd2487f00ad85ed391d18ab445a29eba828d9f1bc1da571555fc--

